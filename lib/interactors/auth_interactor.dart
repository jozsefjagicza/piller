
import 'package:flutter/cupertino.dart';
import 'package:piller/analytics/analytics_service.dart';
import 'package:piller/common/constants.dart';

class AuthInteractor {

  Future<bool> authenticate(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    bool result = ((username == Global.user) && (password == Global.password));
    debugPrint("Authentication result: $result");
    if (result) {
      await AnalyticsService.logLoginSuccess(method: 'AuthInteractor - authenticate');
    }
    else {
      await AnalyticsService.logLoginFailure(reason: 'AuthInteractor - authenticate');
    }
    return result;
  }
}
