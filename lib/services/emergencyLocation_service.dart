import 'dart:convert';

import 'package:app_fireman/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'package:http/http.dart' as http;

class EmergencyLocationService extends ChangeNotifier {
  final String _baseUrl = 'https://server-rest-emergencias.herokuapp.com';
  final storage = new FlutterSecureStorage();
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
      await storage.delete(key: 'location_id');
      await storage.delete(key: 'dscr_location');
        emergenciesLocation = rest.map<Emeregency>((json) => Emeregency.fromMap (json)).toList();
      isLoading = false;
      
      notifyListeners();
      return emergenciesLocation;
    } else {
      return decodedResp['msg'];
    }
  }

  Future<String?> saveLocationEmergency(String uid, String description) async {
   
     await storage.write(key: 'location_id', value: uid);
     await storage.write(key: 'dscr_location', value: description);
    // String value  =await   storage.read(key: 'emergencyType') as String;
    // print(value);
     return null;
  }
}

