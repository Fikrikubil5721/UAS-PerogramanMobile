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
          //Awal province
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
              return controller.getBeginningProvince();
            },
            onChanged: (value) => controller.provId = value?.provinceId ?? '0',
          ),
          SizedBox(
            height: 24,
          ),

          // Awal City
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
              return controller.getBeginningCity();
            },
            onChanged: (value) => controller.cityId = value?.cityId ?? '0',
          ),
          SizedBox(
            height: 44,
          ),

          //Akhir Province
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
              return controller.getBeginningProvince();
            },
            onChanged: (value) =>
                controller.endProvId = value?.provinceId ?? '0',
          ),
          SizedBox(
            height: 24,
          ),

          //Akhir City
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
              return controller.getEndCity();
            },
            onChanged: (value) => controller.endCityId = value?.cityId ?? '0',
          ),
          SizedBox(height: 24),
          TextField(
            controller: controller.beratC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Berat Barang (gram)',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          DropdownSearch<Map<String, dynamic>>(
            items: [
              {'code': 'jne', 'name': 'JNE'},
              {'code': 'pos', 'name': 'POS Indonesia'},
              {'code': 'tiki', 'name': 'TIKI'},
            ],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                // labelText: 'Kurir',
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  '${item['name']}',
                ),
              ),
            ),
            dropdownBuilder: (context, selectedItem) => Text(
              '${selectedItem?['name'] ?? 'Pilih Kurir'}',
            ),
            onChanged: (value) =>
                controller.codeKurir.value = value?['code'] ?? '',
          ),

          SizedBox(height: 24),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.cekOngkir();
                }
              },
              child: Text(
                  controller.isLoading.isFalse ? 'Cek Ongkir' : 'Loading...'),
            ),
          ),
        ],
      ),
    );
  }
}
