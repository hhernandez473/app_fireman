import 'dart:convert';

import 'package:app_fireman/models/models.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

class EmergencyLocationService extends ChangeNotifier {
  final String _baseUrl = 'https://server-rest-emergencias.herokuapp.com';

  final encoding = Encoding.getByName('utf-8');
  final headers = {'Content-Type': 'application/json'};
  bool isLoading = true;
  // Si retornamos algo, es un error, si no, todo bien!
  List<Emeregency> emergenciesLocation = [];

  EmergencyLocationService(){
    emergencyLocation();
  }

  Future<List<Emeregency>> emergencyLocation() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(_baseUrl + '/api/catalogos/descripcionLocaciones');

    final resp = await http.get(url, headers: headers);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('datos')) {
      // Token hay que guardarlo en un lugar seguro
      //decodedResp['datos'];
      //await storage.write(key: 'token', value: decodedResp['token']);
      var rest = decodedResp['datos'] as List;
      
        emergenciesLocation = rest.map<Emeregency>((json) => Emeregency.fromMap (json)).toList();
      isLoading = false;
      notifyListeners();
      return emergenciesLocation;
    } else {
      return decodedResp['msg'];
    }
  }
}

