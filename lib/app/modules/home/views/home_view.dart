import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:check_delivery/app/data/models/province_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../data/models/city_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          DropdownSearch<Province>(
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item.province}'),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: 'Province',
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              final response = await http.get(
                Uri.parse('https://api.rajaongkir.com/starter/province'),
                headers: {
                  'key': 'bf32d82b4c142f1753cdb1508edabe5f',
                },
              );

              if (response.statusCode != 200) {
                return [];
              }

              Map<String, dynamic> data = jsonDecode(response.body);

              return Province.fromJsonList(data['rajaongkir']['results']);
            },
            onChanged: (value) => controller.provId.value = value?.provinceId ?? '0',
          ),
          SizedBox(
            height: 24,
          ),
          DropdownSearch<City>(
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item.type} ${item.cityName}'),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await http.get(
                Uri.parse('https://api.rajaongkir.com/starter/city?province=${controller.provId}'),
                headers: {'key': 'bf32d82b4c142f1753cdb1508edabe5f'},
              );

              Map<String, dynamic> data = jsonDecode(response.body);

              var models = City.fromJsonList(data['rajaongkir']['results']);
              return models;
            },
            onChanged:(value) => controller.citId.value = value?.cityId ?? '0',
          ),

          SizedBox(
            height: 44,
          ),
          DropdownSearch<Province>(
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item.province}'),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Province",
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await http.get(
                Uri.parse('https://api.rajaongkir.com/starter/province'),
                headers: {'key': 'bf32d82b4c142f1753cdb1508edabe5f'},
              );

              Map<String, dynamic> data = jsonDecode(response.body);

              var models = Province.fromJsonList(data['rajaongkir']['results']);
              return models;
            },
            onChanged:(value) => controller.nextProvId.value = value?.provinceId ?? '0',
          ),
          SizedBox(
            height: 24,
          ),
          DropdownSearch<City>(
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item.type} ${item.cityName}'),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await http.get(
                Uri.parse('https://api.rajaongkir.com/starter/city?province=${controller.nextProvId}'),
                headers: {'key': 'bf32d82b4c142f1753cdb1508edabe5f'},
              );

              Map<String, dynamic> data = jsonDecode(response.body);

              var models = City.fromJsonList(data['rajaongkir']['results']);
              return models;
            },
            onChanged:(value) => controller.nextCitId.value = value?.cityId ?? '0',
          ),
        ],
      ),
    );
  }
}
