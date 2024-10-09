
import 'package:idoctusapp/feat/network_image/domain/entities/network_image_entity.dart';

abstract class NetworkImageRepository {
  Future<NetworkImageEntity> getNetworkImage();
}
