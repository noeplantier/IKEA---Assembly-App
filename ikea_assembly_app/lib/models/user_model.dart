import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final String role; // user, admin
  final DateTime createdAt;
  final DateTime lastLogin;
  final List<String> favorites;
  final Map<String, dynamic> preferences;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl = '',
    this.role = 'user',
    required this.createdAt,
    required this.lastLogin,
    this.favorites = const [],
    this.preferences = const {},
    this.isActive = true,
  });

  // Convert Firestore document to UserModel object
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      role: data['role'] ?? 'user',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLogin: (data['lastLogin'] as Timestamp?)?.toDate() ?? DateTime.now(),
      favorites: List<String>.from(data['favorites'] ?? []),
      preferences: Map<String, dynamic>.from(data['preferences'] ?? {}),
      isActive: data['isActive'] ?? true,
    );
  }

  // Convert UserModel object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
      'favorites': favorites,
      'preferences': preferences,
      'isActive': isActive,
    };
  }

  // Create a copy with updated fields
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    String? role,
    DateTime? createdAt,
    DateTime? lastLogin,
    List<String>? favorites,
    Map<String, dynamic>? preferences,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      favorites: favorites ?? this.favorites,
      preferences: preferences ?? this.preferences,
      isActive: isActive ?? this.isActive,
    );
  }

  // Check if user is admin
  bool get isAdmin {
    return role == 'admin';
  }

  // Check if user has favorites
  bool get hasFavorites {
    return favorites.isNotEmpty;
  }

  // Check if furniture is favorited
  bool isFavorite(String furnitureId) {
    return favorites.contains(furnitureId);
  }
}
