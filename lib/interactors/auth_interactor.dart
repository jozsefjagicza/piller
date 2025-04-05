
import 'package:piller/common/constants.dart';

class AuthInteractor {

  Future<bool> authenticate(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return username == Global.user && password == Global.password;
  }
}
