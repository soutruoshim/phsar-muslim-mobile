import 'package:flutter/material.dart';
import 'package:phsar_muslim/data/model/response/address_model.dart';
import 'package:phsar_muslim/data/model/response/province_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AddressProvider extends ChangeNotifier {

  List<Province> _provinceList = [];
  List<District> _districtList = [];
  List<Commune> _communeList = [];
  List<Province>? get provinceList => _provinceList;
  List<District>? get districtList => _districtList;
  List<Commune>? get communeList => _communeList;

  Future<void> readProvince() async {
      String data = await rootBundle.loadString('assets/address/provinces.json');
      final jsonResult = json.decode(data);
      _provinceList.clear();
      jsonResult.forEach((province) => _provinceList.add(Province.fromJson(province)));
      notifyListeners();
  }
  Future<void> readDistrict() async {
    String data = await rootBundle.loadString('assets/address/districts.json');
    final jsonResult = json.decode(data);
    _districtList.clear();
    jsonResult.forEach((district) => _districtList.add(District.fromJson(district)));
    notifyListeners();
  }
  Future<void> readCommune() async {
    String data = await rootBundle.loadString('assets/address/communes.json');
    final jsonResult = json.decode(data);
    _communeList.clear();
    jsonResult.forEach((commune) => _communeList.add(Commune.fromJson(commune)));
    notifyListeners();
  }
}
