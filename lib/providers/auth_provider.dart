import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/interactors/auth_interactor.dart';

class AuthProvider with ChangeNotifier {
  final AuthInteractor _authInteractor = locator<AuthInteractor>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  String? _errorText;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isAuthenticated => _isAuthenticated;

  String? get errorText => _errorText;

  bool get isLoading => _isLoading;

  AuthProvider() {
    usernameFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!usernameFocusNode.hasFocus) {
      _errorText = null;
      notifyListeners();
    }
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();

      bool result = await _authInteractor.authenticate(
        usernameController.text,
        passwordController.text,
      );

      _isLoading = false;
      notifyListeners();

      if (result) {
        _isAuthenticated = true;
        notifyListeners();
      } else {
        _errorText = 'login_validate'.tr();
        notifyListeners();
      }
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      _errorText = 'login_validate_empty_username'.tr();
      return _errorText;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'login_validate_empty_password'.tr();
    }
    if (value.length < 6) {
      return 'login_validate_short_password'.tr();
    }
    return null;
  }

  Future<void> checkAuthStatus(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!_isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}

