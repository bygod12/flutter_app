import 'package:untitled1/views/screens/login/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

import '../ui/fitness_app_home_screen.dart';


class Register_data extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400,
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(1, Text("medidas", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        FadeAnimation(
                          1.4,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      'Cadastre suas medidaas',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 16),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Cabeça',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Pescoço',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Ombros',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Biceps',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Ante-braço',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Cintura',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Quadril',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Coxa',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Panturrilha',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    FadeAnimation(
                                      1.6,
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 50),
                                        child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FitnessAppHomeScreen()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            primary: Colors.orange[900],
                                            minimumSize: Size(double.infinity, 50),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Cadastrar',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 50,),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}