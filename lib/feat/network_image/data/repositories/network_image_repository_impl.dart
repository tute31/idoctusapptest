import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idoctusapp/feat/network_image/domain/entities/network_image_entity.dart';
import 'package:idoctusapp/feat/network_image/domain/repositories/network_image_repository.dart';

class NetworkImageRepositoryImpl implements NetworkImageRepository {
  @override
  Future<NetworkImageEntity> getNetworkImage() async {
    // https://api.thecatapi.com/v1/images/search
    var url = Uri.https('api.thecatapi.com', '/v1/images/search');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return NetworkImageEntity(url: data[0]['url']);
    } else {
      throw Exception('Error al cargar la imagen');
    }
  }
}
