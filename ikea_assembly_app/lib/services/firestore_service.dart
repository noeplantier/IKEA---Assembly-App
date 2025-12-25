import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/furniture_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== FURNITURE OPERATIONS ====================

  // Get all furniture
  Stream<List<Furniture>> getFurniture() {
    return _firestore
        .collection('furniture')
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Furniture.fromFirestore(doc)).toList());
  }

  // Get furniture by category
  Stream<List<Furniture>> getFurnitureByCategory(String category) {
    return _firestore
        .collection('furniture')
        .where('category', isEqualTo: category)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Furniture.fromFirestore(doc)).toList());
  }

  // Get furniture by ID
  Future<Furniture?> getFurnitureById(String furnitureId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('furniture').doc(furnitureId).get();
      if (doc.exists) {
        return Furniture.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get furniture: ${e.toString()}');
    }
  }

  // Search furniture
  Stream<List<Furniture>> searchFurniture(String query) {
    return _firestore
        .collection('furniture')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Furniture.fromFirestore(doc))
          .where((furniture) =>
              furniture.name.toLowerCase().contains(query.toLowerCase()) ||
              furniture.description
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              furniture.tags.any(
                  (tag) => tag.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  // Add furniture (Admin only)
  Future<String> addFurniture(Furniture furniture) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('furniture').add(furniture.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add furniture: ${e.toString()}');
    }
  }

  // Update furniture (Admin only)
  Future<void> updateFurniture(String furnitureId, Furniture furniture) async {
    try {
      await _firestore
          .collection('furniture')
          .doc(furnitureId)
          .update(furniture.toFirestore());
    } catch (e) {
      throw Exception('Failed to update furniture: ${e.toString()}');
    }
  }

  // Delete furniture (Admin only)
  Future<void> deleteFurniture(String furnitureId) async {
    try {
      await _firestore
          .collection('furniture')
          .doc(furnitureId)
          .update({'isActive': false});
    } catch (e) {
      throw Exception('Failed to delete furniture: ${e.toString()}');
    }
  }

  // ==================== USER FAVORITES ====================

  // Get user favorites
  Stream<List<String>> getUserFavorites(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return List<String>.from(snapshot.data()?['favorites'] ?? []);
      }
      return [];
    });
  }

  // Add to favorites
  Future<void> addToFavorites(String userId, String furnitureId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'favorites': FieldValue.arrayUnion([furnitureId])
      });
    } catch (e) {
      throw Exception('Failed to add to favorites: ${e.toString()}');
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorites(String userId, String furnitureId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'favorites': FieldValue.arrayRemove([furnitureId])
      });
    } catch (e) {
      throw Exception('Failed to remove from favorites: ${e.toString()}');
    }
  }

  // Get favorite furniture
  Stream<List<Furniture>> getFavoriteFurniture(String userId) {
    return getUserFavorites(userId).asyncExpand((favoriteIds) {
      if (favoriteIds.isEmpty) {
        return Stream.value([]);
      }
      return _firestore
          .collection('furniture')
          .where(FieldPath.documentId, whereIn: favoriteIds)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Furniture.fromFirestore(doc))
              .toList());
    });
  }

  // ==================== USER PROGRESS ====================

  // Save user progress for a furniture
  Future<void> saveUserProgress(
    String userId,
    String furnitureId,
    int currentStep,
    bool completed,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(furnitureId)
          .set({
        'furnitureId': furnitureId,
        'currentStep': currentStep,
        'completed': completed,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to save progress: ${e.toString()}');
    }
  }

  // Get user progress
  Future<Map<String, dynamic>?> getUserProgress(
    String userId,
    String furnitureId,
  ) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc(furnitureId)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get progress: ${e.toString()}');
    }
  }

  // ==================== CATEGORIES ====================

  // Get all categories
  Stream<List<String>> getCategories() {
    return _firestore.collection('categories').orderBy('name').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => doc.data()['name'] as String).toList());
  }

  // ==================== REVIEWS ====================

  // Add review
  Future<void> addReview(
    String furnitureId,
    String userId,
    double rating,
    String comment,
  ) async {
    try {
      await _firestore.collection('reviews').add({
        'furnitureId': furnitureId,
        'userId': userId,
        'rating': rating,
        'comment': comment,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Update furniture rating
      await _updateFurnitureRating(furnitureId);
    } catch (e) {
      throw Exception('Failed to add review: ${e.toString()}');
    }
  }

  // Update furniture rating
  Future<void> _updateFurnitureRating(String furnitureId) async {
    QuerySnapshot reviews = await _firestore
        .collection('reviews')
        .where('furnitureId', isEqualTo: furnitureId)
        .get();

    if (reviews.docs.isNotEmpty) {
      double totalRating = 0;
      for (var doc in reviews.docs) {
        totalRating += (doc.data() as Map<String, dynamic>)['rating'] as double;
      }
      double averageRating = totalRating / reviews.docs.length;

      await _firestore.collection('furniture').doc(furnitureId).update({
        'rating': averageRating,
        'reviewCount': reviews.docs.length,
      });
    }
  }

  // Get reviews for furniture
  Stream<List<Map<String, dynamic>>> getFurnitureReviews(String furnitureId) {
    return _firestore
        .collection('reviews')
        .where('furnitureId', isEqualTo: furnitureId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  // ==================== ANALYTICS ====================

  // Track furniture view
  Future<void> trackFurnitureView(String userId, String furnitureId) async {
    try {
      await _firestore.collection('analytics').add({
        'userId': userId,
        'furnitureId': furnitureId,
        'action': 'view',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Fail silently for analytics
    }
  }

  // Track assembly start
  Future<void> trackAssemblyStart(String userId, String furnitureId) async {
    try {
      await _firestore.collection('analytics').add({
        'userId': userId,
        'furnitureId': furnitureId,
        'action': 'start_assembly',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Fail silently for analytics
    }
  }

  // Track assembly complete
  Future<void> trackAssemblyComplete(String userId, String furnitureId) async {
    try {
      await _firestore.collection('analytics').add({
        'userId': userId,
        'furnitureId': furnitureId,
        'action': 'complete_assembly',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Fail silently for analytics
    }
  }
}
