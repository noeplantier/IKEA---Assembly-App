import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  User? get currentFirebaseUser => _authService.currentUser;
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  // Sign in with email and password
  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.signInWithEmailPassword(email, password);
      await _loadUserData();

      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Register with email and password
  Future<bool> registerWithEmailPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.registerWithEmailPassword(
          email, password, displayName);
      await _loadUserData();

      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.signInWithGoogle();
      await _loadUserData();

      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _setLoading(true);
      await _authService.signOut();
      _user = null;
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.resetPassword(email);

      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Update profile
  Future<bool> updateProfile(String displayName, String? photoUrl) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.updateUserProfile(displayName, photoUrl);
      await _loadUserData();

      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Load user data from Firestore
  Future<void> _loadUserData() async {
    if (_authService.currentUser != null) {
      _user = await _authService.getUserDocument(
        _authService.currentUser!.uid,
      );
      notifyListeners();
    }
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
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Delete account
  Future<bool> deleteAccount() async {
    try {
      _setLoading(true);
      await _authService.deleteAccount();
      _user = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
}
