import 'dart:convert';
import 'dart:io';

import 'package:app_fireman/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;


class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-14e0e-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct = new Product(available: true, name: '', price: 10);
  final storage = new FlutterSecureStorage();
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async {

    this.isLoading = true;
    notifyListeners();
    
    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.get( url );

    //final Map<String, dynamic> productsMap = json.decode( resp.body );

    // productsMap.forEach((key, value) {
    //   final tempProduct = Product.fromMap( value );
    //   tempProduct.id = key;
    //   this.products.add( tempProduct );
    // });


    this.isLoading = false;
    notifyListeners();

    return this.products;

  }


  Future saveOrCreateProduct( Product product ) async {

    isSaving = true;
    notifyListeners();

    if ( product.id == null ) {
      // Es necesario crear
      await this.createProduct( product );
    } else {
      // Actualizar
      await this.updateProduct( product );
    }



    isSaving = false;
    notifyListeners();

  }
  

  Future<String> updateProduct( Product product ) async {

    final url = Uri.https( _baseUrl, 'products/${ product.id }.json');
    final resp = await http.put( url, body: product.toJson() );
    final decodedData = resp.body;

    //TODO: Actualizar el listado de productos
    final index = this.products.indexWhere((element) => element.id == product.id );
    this.products[index] = product;

    return product.id!;

  }

  Future<String> createProduct( Product product ) async {

    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.post( url, body: product.toJson() );
    final decodedData = json.decode( resp.body );

    product.id = decodedData['name'];

    this.products.add(product);
    

    return product.id!;

  }
  

  void updateSelectedProductImage( String path ) {

    this.selectedProduct.picture = path;
    this.newPictureFile = File.fromUri( Uri(path: path) );

    notifyListeners();

  }

  Future<String?> uploadImage() async {

    if (  this.newPictureFile == null ) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://server-rest-emergencias.herokuapp.com/api/uploads');

    final imageUploadRequest = http.MultipartRequest('POST', url );

    final file = await http.MultipartFile.fromPath('archivo', newPictureFile!.path );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('algo salio mal');
      print( resp.body );
      return null;
    }
    isSaving = false;
    this.newPictureFile = null;

    final decodedData = json.decode( resp.body );
    await storage.write(key: 'url', value: decodedData['url']);
    return decodedData['url'];

  }

}