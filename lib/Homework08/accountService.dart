import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountService {
  static const String _tokenKey = "token";
  static const String _user = "user";
  final _storage = const FlutterSecureStorage();

  Future<String?> readUser() async {
    final user = await _storage.read(key: _user);
    return user;
  }

  Future<String?> readToken() async {
    final token = await _storage.read(key: _tokenKey);
    return token;
  }

  Future<void> saveUser(String user) async {
    await _storage.write(key: _user, value: user);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: _user);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<void> logout() async {
    await deleteToken();
    await deleteUser();
  }
}
