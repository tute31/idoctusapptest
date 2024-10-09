import 'package:idoctusapp/feat/auth/domain/usecases/auth_use_case.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthUseCase authUseCase;

  AuthRepositoryImpl({required this.authUseCase});

  @override
  Future<bool> authenticate(String password) async {
    return authUseCase(password);
  }
}
