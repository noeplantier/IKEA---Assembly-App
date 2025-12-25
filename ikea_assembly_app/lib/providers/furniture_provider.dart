import 'package:flutter/foundation.dart';
import '../models/furniture_model.dart';
import '../services/firestore_service.dart';

class FurnitureProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Furniture> _allFurniture = [];
  List<Furniture> _filteredFurniture = [];
  List<String> _favorites = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _errorMessage;

  List<Furniture> get furniture => _filteredFurniture;
  List<String> get favorites => _favorites;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Initialize furniture stream
  void initializeFurnitureStream() {
    _firestoreService.getFurniture().listen(
      (furnitureList) {
        _allFurniture = furnitureList;
        _applyFilters();
      },
      onError: (error) {
        _setError(error.toString());
      },
    );
  }

  // Initialize favorites stream
  void initializeFavoritesStream(String userId) {
    _firestoreService.getUserFavorites(userId).listen(
      (favoriteIds) {
        _favorites = favoriteIds;
        notifyListeners();
      },
      onError: (error) {
        _setError(error.toString());
      },
    );
  }

  // Set category filter
  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  // Apply filters
  void _applyFilters() {
    _filteredFurniture = _allFurniture.where((furniture) {
      bool matchesCategory =
          _selectedCategory == 'All' || furniture.category == _selectedCategory;

      bool matchesSearch = _searchQuery.isEmpty ||
          furniture.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          furniture.description
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    notifyListeners();
  }

  // Get furniture by ID
  Future<Furniture?> getFurnitureById(String furnitureId) async {
    try {
      return await _firestoreService.getFurnitureById(furnitureId);
    } catch (e) {
      _setError(e.toString());
      return null;
    }
  }

  // Toggle favorite
  Future<void> toggleFavorite(String userId, String furnitureId) async {
    try {
      if (_favorites.contains(furnitureId)) {
        await _firestoreService.removeFromFavorites(userId, furnitureId);
      } else {
        await _firestoreService.addToFavorites(userId, furnitureId);
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Check if furniture is favorite
  bool isFavorite(String furnitureId) {
    return _favorites.contains(furnitureId);
  }

  // Get favorite furniture
  Stream<List<Furniture>> getFavoriteFurniture(String userId) {
    return _firestoreService.getFavoriteFurniture(userId);
  }

  // Save user progress
  Future<void> saveProgress(
    String userId,
    String furnitureId,
    int currentStep,
    bool completed,
  ) async {
    try {
      await _firestoreService.saveUserProgress(
        userId,
        furnitureId,
        currentStep,
        completed,
      );
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Get user progress
  Future<Map<String, dynamic>?> getProgress(
    String userId,
    String furnitureId,
  ) async {
    try {
      return await _firestoreService.getUserProgress(userId, furnitureId);
    } catch (e) {
      _setError(e.toString());
      return null;
    }
  }

  // Track furniture view
  Future<void> trackView(String userId, String furnitureId) async {
    await _firestoreService.trackFurnitureView(userId, furnitureId);
  }

  // Track assembly start
  Future<void> trackAssemblyStart(String userId, String furnitureId) async {
    await _firestoreService.trackAssemblyStart(userId, furnitureId);
  }

  // Track assembly complete
  Future<void> trackAssemblyComplete(String userId, String furnitureId) async {
    await _firestoreService.trackAssemblyComplete(userId, furnitureId);
  }

  // Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Get furniture by category
  List<Furniture> getFurnitureByCategory(String category) {
    return _allFurniture
        .where((furniture) => furniture.category == category)
        .toList();
  }

  // Get all categories
  List<String> getCategories() {
    Set<String> categories =
        _allFurniture.map((furniture) => furniture.category as String).toSet();
    return ['All', ...categories.toList()..sort()];
  }
}

class Furniture {
  get category => null;

  get name => null;

  get description => null;
}
