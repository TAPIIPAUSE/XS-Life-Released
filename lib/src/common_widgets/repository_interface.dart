import 'package:xs_life/src/features/authentication/data/auth_service.dart';

abstract class IRepository {
  Future<void> checkAuth() async {
    if (!AuthService.loggedIn()) {
      throw Exception('Must be logged in');
    }
  }
}