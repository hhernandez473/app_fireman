import 'package:app_fireman/screens/screens.dart';
import 'package:app_fireman/services/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    final emergency = Provider.of<EmergencyTypeService>(context);
    print(emergency.emergenciesType);
    if (emergency.isLoading) return LoadingScreen();
    List boxes = ["box1", "box2", "box3", "box4", "box5", "box6"];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu Principal'),
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
              children: emergency.emergenciesType.map((box) {
                return Container(
                    margin: const EdgeInsets.all(10),
                   
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                     
                    ),
                    height: 140,
                    width: 140,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/' + box.img),
                          iconSize: 75,
                          onPressed: () {
                            final route = MaterialPageRoute(
                                builder: (context) => EmergencyLocation());
                            Navigator.push(context, route);
                          },
                        ),
                        Text(box.nombre, textAlign: TextAlign.center,)
                      ],
                    ));
              }).toList(),
            ))
        // body: Center(
        //   child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           SizedBox.fromSize(
        //             size: Size(200, 200), // button width and height

        //             child: Material(
        //               color: Colors.white, // button color
        //               child: InkWell(
        //                 splashColor: Colors.green, // splash color
        //                 onTap: () {}, // button pressed
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/images/choque.png'),
        //                       iconSize: 150,
        //                       onPressed: () {},
        //                     ),
        //                     Text("Call"), // text
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           SizedBox(height: 30),
        //           SizedBox.fromSize(
        //             size: Size(200, 200), // button width and height

        //             child: Material(
        //               color: Colors.white, // button color
        //               child: InkWell(
        //                 splashColor: Colors.green, // splash color
        //                 onTap: () {}, // button pressed
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/images/choque.png'),
        //                       iconSize: 150,
        //                       onPressed: () {},
        //                     ),
        //                     Text("Call"), // text
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           SizedBox(height: 30),
        //           SizedBox.fromSize(
        //             size: Size(200, 200), // button width and height

        //             child: Material(
        //               color: Colors.white, // button color
        //               child: InkWell(
        //                 splashColor: Colors.green, // splash color
        //                 onTap: () {}, // button pressed
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/images/choque.png'),
        //                       iconSize: 150,
        //                       onPressed: () {},
        //                     ),
        //                     Text("Call"), // text
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           SizedBox(height: 30),
        //           SizedBox.fromSize(
        //             size: Size(200, 200), // button width and height

        //             child: Material(
        //               color: Colors.white, // button color
        //               child: InkWell(
        //                 splashColor: Colors.green, // splash color
        //                 onTap: () {}, // button pressed
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/images/choque.png'),
        //                       iconSize: 150,
        //                       onPressed: () {},
        //                     ),
        //                     Text("Call"), // text
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           // CardContainer(
        //           //     child: Column(
        //           //   children: [
        //           //     IconButton(
        //           //       icon: Image.asset('assets/images/choque.png'),
        //           //       iconSize: 50,
        //           //       onPressed: () {},
        //           //     ),

        //           //   ],
        //           // )),
        //         ],
        //       )
        //   ),

        // ),
        );
  }
}
