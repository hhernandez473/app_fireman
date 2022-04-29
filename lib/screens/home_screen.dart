import 'package:app_fireman/services/services.dart';
import 'package:app_fireman/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
        shadowColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            
            CardContainer(
                child: Column(
              children: [
                SizedBox(height: 10),
                Text('Bienvenido',
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 30),
              ],
            )),
          ],
        )),
      ),
    );
  }
}
