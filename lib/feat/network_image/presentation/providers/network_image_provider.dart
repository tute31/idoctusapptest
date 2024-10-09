import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idoctusapp/feat/network_image/data/repositories/network_image_repository_impl.dart';
import 'package:idoctusapp/feat/network_image/domain/entities/network_image_entity.dart';
import 'package:idoctusapp/feat/network_image/domain/usecases/network_image_use_case.dart';

final networkImageRepositoryProvider =
    Provider<NetworkImageRepositoryImpl>((ref) {
  return NetworkImageRepositoryImpl();
});

final networkImageUseCaseProvider = Provider<NetworkImageUseCase>((ref) {
  return NetworkImageUseCase(
      repository: ref.read(networkImageRepositoryProvider));
});

final networkImageStateProvider =
    StateNotifierProvider<NetworkImageNotifier, AsyncValue<NetworkImageEntity>>(
        (ref) {
  return NetworkImageNotifier(ref.read(networkImageUseCaseProvider));
});

class NetworkImageNotifier
    extends StateNotifier<AsyncValue<NetworkImageEntity>> {
  final NetworkImageUseCase networkImageUseCase;

  NetworkImageNotifier(this.networkImageUseCase)
      : super(const AsyncValue.loading()) {
    fetchImage();
  }

  Future<void> fetchImage() async {
    try {
      state = const AsyncValue.loading();
      final image = await networkImageUseCase();
      state = AsyncValue.data(image);
    } catch (e, str) {
      state = AsyncValue.error(e, str);
    }
  }
}
