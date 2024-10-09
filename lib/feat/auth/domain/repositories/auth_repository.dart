abstract class AuthRepository {
  Future<bool> authenticate(String password);
}
