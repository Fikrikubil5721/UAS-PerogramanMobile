import 'package:get/get.dart';

import '../models/city_model.dart';

class CityProvider extends GetConnect {
  // @override
  // void onInit() {
  //   httpClient.defaultDecoder = (map) {
  //     if (map is Map<String, dynamic>) return City.fromJson(map);
  //     if (map is List) return map.map((item) => City.fromJson(item)).toList();
  //   };
  //   httpClient.baseUrl = 'YOUR-API-URL';
  // }

  Future<List<City>> getCity(String provId) async {
    final response = await get(
      'https://api.rajaongkir.com/starter/city?province=$provId',
      headers: {'key': 'bf32d82b4c142f1753cdb1508edabe5f'},
    );
    return City.fromJsonList(response.body['rajaongkir']['results']);
  }
  // Future<Response<City>> postCity(City city) async => await post('city', city);
  // Future<Response> deleteCity(int id) async => await delete('city/$id');
}
