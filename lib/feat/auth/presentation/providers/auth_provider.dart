import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idoctusapp/feat/auth/domain/usecases/auth_use_case.dart';
import '../../data/repositories/auth_repository_impl.dart';

final authUseCaseUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCase();
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(authUseCase: ref.read(authUseCaseUseCaseProvider));
});

final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(ref.read(authRepositoryProvider));
});

class AuthStateNotifier extends StateNotifier<bool> {
  final AuthRepositoryImpl authRepository;

  AuthStateNotifier(this.authRepository) : super(false);

  Future<void> login(String password) async {
    final isAuthenticated = await authRepository.authenticate(password);
    state = isAuthenticated;
  }
}
