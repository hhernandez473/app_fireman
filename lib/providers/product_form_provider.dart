import 'package:app_fireman/models/models.dart';
import 'package:flutter/material.dart';


class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();


  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ProductFormProvider( );

  get product => null;

  updateAvailability( bool value ) {
    print(value);
    //this.product.available = value;
    notifyListeners();
  }

  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {

    // print( product.name );
    // print( product.price );
    // print( product.available );

    return formKey.currentState?.validate() ?? false;
  }

}