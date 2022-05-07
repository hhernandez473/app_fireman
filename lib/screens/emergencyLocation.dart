
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
                    margin: const EdgeInsets.all(5),
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 130,
                    width: 100,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/'+box.img),
                          iconSize: 75,
                          onPressed: () {},
                        ),
                         Text(box.nombre)
                      ],
                    ));
              }).toList(),
            ))
      
        );
  }
}
