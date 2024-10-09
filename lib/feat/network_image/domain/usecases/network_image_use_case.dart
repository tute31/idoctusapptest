import 'package:idoctusapp/feat/network_image/domain/entities/network_image_entity.dart';
import 'package:idoctusapp/feat/network_image/domain/repositories/network_image_repository.dart';

class NetworkImageUseCase {
  final NetworkImageRepository repository;

  NetworkImageUseCase({required this.repository});

  Future<NetworkImageEntity> call() async {
    return await repository.getNetworkImage();
  }
}
