

import 'package:app_fireman/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class MapServices extends ChangeNotifier {
  
  final storage = new FlutterSecureStorage();
 
  bool isLoading = true;
  // Si retornamos algo, es un error, si no, todo bien!
 

  
 

  Future<String?> setCoordenates(String latitude, String longitude) async {
   
     await storage.write(key: 'latitude', value: latitude);
     await storage.write(key: 'longitude', value: longitude);
     //await storage.write(key: 'url', value: 'https://picsum.photos/id/1074/200/200');
    // String value  =await   storage.read(key: 'emergencyType') as String;
    // print(value);
     return null;
  }
}


