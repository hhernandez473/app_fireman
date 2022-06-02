import 'dart:convert';
import 'dart:ffi';

import 'package:app_fireman/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ConfirmationServices extends ChangeNotifier {
  final String _baseUrl = 'https://server-rest-emergencias.herokuapp.com';
  final storage = new FlutterSecureStorage();
  final encoding = Encoding.getByName('utf-8');
  final headers = {'Content-Type': 'application/json'};
  String dscrType = '';
  String dscrLocation = '';
  String url = '';
  bool isLoading = true;
  // Si retornamos algo, es un error, si no, todo bien!
  Information infoData =
      Information(tipoEmergencia: '', locacionEmergencia: '', url: '');

  ConfirmationServices() {
    informationData();
  }

  Future<Information> informationData() async {
    isLoading = true;
    notifyListeners();
    // final url = Uri.parse(_baseUrl + '/api/catalogos/tipoEmergencias');

    // final resp = await http.get(url, headers: headers);
    // final Map<String, dynamic> decodedResp = json.decode(resp.body);
    dscrType = await storage.read(key: 'dscr_type') as String;
    dscrLocation = await storage.read(key: 'dscr_location') as String;
    url = await storage.read(key: 'url') as String;
    if (dscrLocation.isNotEmpty) {
      infoData = Information(
          tipoEmergencia: dscrType, locacionEmergencia: dscrLocation, url: url);
      isLoading = false;
      notifyListeners();
      return infoData;
    }

    return Information(
        tipoEmergencia: dscrType, locacionEmergencia: dscrLocation, url: url);
  }

  Future<String?> sendEmergency() async {
    // String value  =await   storage.read(key: 'emergencyType') as String;
    // print(value);
    String latitude = await storage.read(key: 'latitude') as String;
    String longitude = await storage.read(key: 'longitude') as String;
    String emergencyType = await storage.read(key: 'emergencyType') as String;
    String location_id = await storage.read(key: 'location_id') as String;
    String userId = await storage.read(key: 'userId') as String;
    String datetime = DateTime.now().toString();
    final Map<String, dynamic> authData = {
      'tipo': emergencyType,
      'usuario': userId,
      'fechaEnvio': datetime,
      'descripcionLocacion': location_id,
      'img': this.url,
      'location': {
        'type': 'Point',
        'coordinates': [double.parse(longitude), double.parse(latitude)]
      }
    };

    String jsonBody = json.encode(authData);
    final url = Uri.parse(_baseUrl + '/api/emergencias');

    final resp = await http.post(url,
        headers: headers, body: jsonBody, encoding: encoding);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
  
    // ignore: unrelated_type_equality_checks
    if ( decodedResp['codigo'] == 0) {
      String token = await storage.read(key: 'token') as String;

    
      await storage.deleteAll();
      await storage.write(key: 'token', value: token);
      await storage.write(key: 'userId', value: userId);
      // Token hay que guardarlo en un lugar seguro
     
      //print(decodedResp);
      return null;
    } else {
      return decodedResp['msg'];
    }
  }
}
