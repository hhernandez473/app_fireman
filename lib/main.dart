import 'package:app_fireman/screens/product_screen.dart';
import 'package:app_fireman/screens/screens.dart';
import 'package:app_fireman/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(create: ( _ ) => EmergencyTypeService() ),
        ChangeNotifierProvider(create: ( _ ) => EmergencyLocationService() ),
        ChangeNotifierProvider(create: ( _ ) => ProductsService() ),
        ChangeNotifierProvider(create: ( _ ) => ConfirmationServices() ),
        ChangeNotifierProvider(create: ( _ ) => MapServices() ),
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firemen App',
      initialRoute: 'checking',
      routes: {
        'checking': (_) => CheckAuthScreen(),
       
        'home': (_) => HomeScreen(),
        'emergencyLocation': (_) => EmergencyLocation(),
        'login': (_) => LoginScreen(),
        'register':  (_) => RegisterScreen(),
        'mapaPage': (_) => MapaPage(),
        'emergencyImage': (_) => ProductScreen(),
        'confirmation': (_) => ConfirmationScreen()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
       theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}