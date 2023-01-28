import 'dart:convert';

import 'package:check_delivery/app/data/models/ongkir_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:check_delivery/app/data/providers/city_provider.dart';
import 'package:check_delivery/app/data/providers/province_provider.dart';

import '../../../data/models/city_model.dart';
import '../../../data/models/province_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();
  ProvinceProvider provProvince = ProvinceProvider();
  CityProvider provCity = CityProvider();

  List<Ongkir> ongkosKirim = [];

  String provId = '';
  String cityId = '';
  String endProvId = '';
  String endCityId = '';

  RxBool isLoading = false.obs;

  RxString codeKurir = ''.obs;

  Future<List<Province>> getBeginningProvince() async {
    return await provProvince.getProvince();
  }

  Future<List<Province>> getEndProvince() async {
    return await provProvince.getProvince();
  }

  Future<List<City>> getBeginningCity() async {
    return await provCity.getCity(provId);
  }

  Future<List<City>> getEndCity() async {
    return await provCity.getCity(endProvId);
  }

  void cekOngkir() async {
    if (provId != '0' &&
        endProvId != '0' &&
        cityId != '0' &&
        endCityId != '0' &&
        codeKurir != '') {
      try {
        isLoading.value = true;

        final response = await http.post(
          Uri.parse('https://api.rajaongkir.com/starter/cost'),
          headers: {
            'content-type': 'application/x-www-form-urlencoded',
            'key': 'bf32d82b4c142f1753cdb1508edabe5f'
          },
          body: {
            'origin': cityId,
            'destination': endCityId,
            'weight': beratC.text,
            'courier': codeKurir.value,
          },
        );

        isLoading.value = false;
        List rajaongkir =
            jsonDecode(response.body)['rajaongkir']['results'][0]['costs'];

        ongkosKirim = Ongkir.fromJsonList(rajaongkir);

        Get.defaultDialog(
          title: 'Ongkos Kirim',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ongkosKirim
                .map(
                  (e) => ListTile(
                    title: Text(
                      '${e.service!.toUpperCase()}',
                    ),
                    subtitle: Text(
                      e.cost![0].value.toString(),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        Get.defaultDialog(title: e.toString());
      }
    } else {
      Get.defaultDialog(title: 'Error', middleText: 'Kurang Lengkap');
    }
  }
}
