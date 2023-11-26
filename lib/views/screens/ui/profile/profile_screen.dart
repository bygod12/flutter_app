import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:untitled1/views/screens/login/login.dart';

import '../../../../controllers/userController.dart';
import '../../../../models/user.dart';
import '../../login/Animation/FadeAnimation.dart';
class ProfileScreen extends StatelessWidget {
  final UserController _userController = UserController(); // Instância do UserController

  @override
  Widget build(BuildContext context) {
    final user = _userController.loggedInUser; // Obtém o usuário logado

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              if (user != null) // Verifica se o usuário está logado
                Column(
                  children: [
                    Text(
                      user.name, // Exibe o nome do usuário logado
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ProfileInfoCard(user: user), // Passa o usuário para o widget ProfileInfoCard
                  ],
                ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    print(user);
                    _userController.removeUser(); // Remove o usuário logado ao fazer logout
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    primary: Colors.blueGrey,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final User user;

  ProfileInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(user.name), // Exibe o nome do usuário logado
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(user.email), // Exibe o email do usuário logado
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
