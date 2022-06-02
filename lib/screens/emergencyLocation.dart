
import 'package:app_fireman/screens/screens.dart';
import 'package:app_fireman/services/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyLocation extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    final emergency = Provider.of<EmergencyLocationService>(context);
    print(emergency.emergenciesLocation);
    if( emergency.isLoading ) return LoadingScreen();
    List boxes = ["box1", "box2", "box3", "box4", "box5", "box6"];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dónde está el lugar'),
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
            child: Wrap(
              
              children: emergency.emergenciesLocation.map((box) {
                return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                     
                    ),
                    alignment: Alignment.center,
                    height: 140,
                    width: 140,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/'+box.img),
                          iconSize: 75,
                          onPressed: () {
                            emergency.saveLocationEmergency(box.uid, box.nombre);
                             final route = MaterialPageRoute(
                                builder: (context) => MapaPage());
                            
                            Navigator.push(context, route);
                          },
                        ),
                         Text(box.nombre, textAlign: TextAlign.center)
                      ],
                    ));
              }).toList(),
            ))
      
        );
  }
}
