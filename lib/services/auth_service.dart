import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'https://server-rest-emergencias.herokuapp.com';
  final String _firebaseToken = 'AIzaSyBcytoCbDUARrX8eHpcR-Bdrdq0yUmSjf8';
  final storage = new FlutterSecureStorage();
  final encoding = Encoding.getByName('utf-8');
  final headers = {'Content-Type': 'application/json'};
  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser(String name, String email, String password) async {
    final Map<String, dynamic> authData = {
      'nombre': name,
      'correo': email,
      'password': password,
      'role': '616062b2bd9f5729ac9d9c1c'
    };
    String jsonBody = json.encode(authData);

    final url = Uri.parse(_baseUrl + '/api/usuarios');

    final resp = await http.post(url,
        headers: headers, body: jsonBody, encoding: encoding);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      decodedResp['idToken'];
      await storage.write(key: 'token', value: decodedResp['token']);
      //print(decodedResp);
      return null;
    } else {
      return decodedResp['msg'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'correo': email,
      'password': password
    };
    String jsonBody = json.encode(authData);

    final url = Uri.parse(_baseUrl + '/api/auth/login');

    final resp = await http.post(url,
        headers: headers, body: jsonBody, encoding: encoding);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      decodedResp['idToken'];
      await storage.write(key: 'token', value: decodedResp['token']);
      //print(decodedResp);
      return null;
    } else {
      return decodedResp['msg'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
