import 'package:app_fireman/screens/screens.dart';
import 'package:app_fireman/services/services.dart';
import 'package:app_fireman/ui/input_decorations.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widget.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    final confirmation = Provider.of<ConfirmationServices>(context);
    print(confirmation.infoData);
    if (confirmation.isLoading) return LoadingScreen();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirmación'),
          shadowColor: Colors.deepPurple,
           backgroundColor: const Color.fromARGB(255, 194, 37, 45),
          actions: [
            IconButton(
              icon: const Icon(Icons.login_outlined),
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(15),
          child: Column(children: [

            CardContainer(
              child: Column(
                children: [
                  Text('Resumen de Información', style: TextStyle( fontSize: 18, color: Colors.black87 )),
                  SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              enabled: false,
              initialValue: confirmation.infoData.tipoEmergencia,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Tipo de emergencia',
                //prefixIcon: Icons.alternate_email_rounded
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              enabled: false,
              initialValue: confirmation.infoData.locacionEmergencia,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Descripción de Ubicación',
                //prefixIcon: Icons.alternate_email_rounded
              ),

            ),
             SizedBox(height: 10),
             EmergencyImage(url: confirmation.infoData.url),
             
                ],
              ),
            ),
            
          ]),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
           final String? errorMessage =  await confirmation.sendEmergency();

                if ( errorMessage == null ) {

                  NotificationsService.showSnackbar('Emergencia enviada correctamente');
                  await Future.delayed(Duration(seconds: 2));
                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  // TODO: mostrar error en pantalla
                  // print( errorMessage );
                  NotificationsService.showSnackbar('No se puedo enviar la emergencia, intente de nuevo');
                  
                }
        },
        backgroundColor: Color.fromARGB(255, 25, 26, 25),
        child: const Icon(Icons.save),
      ),);
  }
}
