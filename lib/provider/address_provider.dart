import 'package:flutter/material.dart';
import 'package:phsar_muslim/data/model/response/province_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AddressProvider extends ChangeNotifier {

  List<Province> _provinceList = [];
  List<Province>? get provinceList => _provinceList;

  Future<void> readProvince() async {
      String data = await rootBundle.loadString('assets/address/provinces.json');
      final jsonResult = json.decode(data);
      //print(jsonResult);
      _provinceList.clear();
      jsonResult.forEach((province) => _provinceList.add(Province.fromJson(province)));
      //_provinceList = jsonResult.map((province) => Province.fromJson(province)).toList();
      notifyListeners();
  }
}
