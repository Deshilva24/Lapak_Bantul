import 'package:google_sign_in/google_sign_in.dart';

class GoogleUserService {
  static final GoogleUserService _instance = GoogleUserService._internal();

  GoogleSignInAccount? _currentUser;
  GoogleSignInAuthentication? _currentAuth;

  GoogleUserService._internal();

  factory GoogleUserService() {
    return _instance;
  }

  // Getter untuk mengakses user saat ini
  GoogleSignInAccount? get currentUser => _currentUser;
  GoogleSignInAuthentication? get currentAuth => _currentAuth;

  // Method untuk menyimpan user data setelah login
  void setUser(GoogleSignInAccount user, GoogleSignInAuthentication auth) {
    _currentUser = user;
    _currentAuth = auth;
  }

  // Method untuk logout
  void clearUser() {
    _currentUser = null;
    _currentAuth = null;
  }

  // Method untuk cek apakah user sudah login
  bool get isLoggedIn => _currentUser != null;

  // Method untuk mendapatkan nama lengkap user
  String get userDisplayName => _currentUser?.displayName ?? 'User';

  // Method untuk mendapatkan email user
  String get userEmail => _currentUser?.email ?? '';

  // Method untuk mendapatkan photo URL user
  String get userPhotoUrl => _currentUser?.photoUrl ?? '';
}
