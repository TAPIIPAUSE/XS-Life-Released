import 'package:flutter/material.dart';
import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class ProfileEditState extends ChangeNotifier {
  ProfileEditState() {
    init();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  UserDetail? _userDetail;
  UserDetail? get userDetail => _userDetail;

  UserRepository userRepository = UserRepository();

  Future<void> init() async {
    _userDetail = await userRepository.getUserDetails(AuthService.getUid());
    _isLoading = false;
    notifyListeners();
  }
}