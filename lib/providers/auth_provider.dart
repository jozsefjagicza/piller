import 'package:auth_token_generator/auth_token_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/analytics/analytics_service.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/interactors/auth_interactor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthProvider with ChangeNotifier {
  final AuthInteractor _authInteractor = locator<AuthInteractor>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  bool obscureText = true;

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
        await _saveToken();
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

    if (!await _isLoggedIn()) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Global.authToken);
    bool authenticated = token != null && token.isNotEmpty;
    _isAuthenticated = authenticated;
    return authenticated;
  }

  String _generateToken() {
    final secretKey = Uuid().toString();
    final userId = Global.user;
    final token = AuthTokenGenerator.generateBearerToken(secretKey, userId: userId);

    return token;
  }

  Future<void> _saveToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = _generateToken();
    await prefs.setString(Global.authToken, token);
    await AnalyticsService.logTokenSaved(token: token);
  }
}

