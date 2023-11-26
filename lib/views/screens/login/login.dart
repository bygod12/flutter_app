import 'package:untitled1/controllers/refeicoesController.dart';
import 'package:untitled1/views/screens/login/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/views/screens/login/register.dart';

import '../../../controllers/userController.dart';
import '../ui/fitness_app_home_screen.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final UserController userController = UserController(); // Crie uma instância do UserController
  final RefeicaoController refeicaoController = RefeicaoController();
  Future<void> _login(BuildContext context) async {
    final email = emailController.text;
    final senha = senhaController.text;

    try {
      // Chame a função de verificação de usuário do UserController
      final isValidUser = await userController.verifyUser(email, senha);
      print(isValidUser);
      if (isValidUser) {
        // Se a verificação for bem-sucedida, navegue para a tela principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => FitnessAppHomeScreen(),
          ),
        );
      } else {
        // Se a verificação falhar, mostre uma mensagem de erro ao usuário
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro de Autenticação'),
              content: Text('Credenciais de login inválidas.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Trate qualquer erro que possa ocorrer durante a verificação
      print('Erro durante a verificação de usuário: $e');
    }
  }

  @override
  void initState() {

  }

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
                  FadeAnimation(1, Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
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
                        FadeAnimation(1.4, Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  controller: emailController, // Atribua o controller ao campo de email
                                  decoration: InputDecoration(
                                    labelText: "Seu Email", // Label para o campo de email
                                    hintText: "Digite seu email", // Sugestão dentro do campo de email
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  controller: senhaController, // Atribua o controller ao campo de senha
                                  decoration: InputDecoration(
                                    labelText: "Senha", // Label para o campo de senha
                                    hintText: "Digite sua senha", // Sugestão dentro do campo de senha
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        SizedBox(height: 40,),
                        FadeAnimation(
                          1.6,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: ElevatedButton(
                              onPressed: (){
                                _login(context); // Chame a função _login ao pressionar o botão de login

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
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        FadeAnimation(
                          1.6,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Register()));
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
                                  'Registrar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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