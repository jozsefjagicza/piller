
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/interactors/auth_interactor.dart';

class AuthProvider with ChangeNotifier {
  final AuthInteractor _authInteractor =  locator<AuthInteractor>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  String? _errorText;
  bool _isAuthenticated = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isAuthenticated => _isAuthenticated;
  String? get errorText => _errorText;

  AuthProvider() {
    emailFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!emailFocusNode.hasFocus) {
      _errorText = null;
      notifyListeners();
    }
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      bool result = await _authInteractor.authenticate(
        emailController.text,
        passwordController.text,
      );

      if (result) {
        _isAuthenticated = true;
        notifyListeners();
      } else {
        _errorText = 'login_validate'.tr();
        notifyListeners();
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      _errorText = 'login_validate_empty_email'.tr();
      return _errorText;
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}").hasMatch(value)) {
      _errorText = 'login_validate_email_format'.tr();
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
}
