import 'package:get/get.dart';

import '../models/province_model.dart';

class ProvinceProvider extends GetConnect {
  

  Future<List<Province>> getProvince() async {
    final response = await get('https://api.rajaongkir.com/starter/province',headers:  {'key': 'bf32d82b4c142f1753cdb1508edabe5f'},);
    return Province.fromJsonList(response.body['rajaongkir']['results']);
  }

  

  // Future<Response<Province>> postProvince(Province province) async =>
  //     await post('province', province);
  // Future<Response> deleteProvince(int id) async => await delete('province/$id');
}
