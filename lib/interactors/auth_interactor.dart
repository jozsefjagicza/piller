
class AuthInteractor {

  Future<bool> authenticate(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return email == "test@example.com" && password == "password123";
  }
}
