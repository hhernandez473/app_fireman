import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergencias'),
         backgroundColor: const Color.fromARGB(255, 194, 37, 45),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
          
        ),
     ),
   );
  }
}