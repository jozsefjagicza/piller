
class AuthInteractor {

  Future<bool> authenticate(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return username == "Piller" && password == "PillerPassword";
  }
}
