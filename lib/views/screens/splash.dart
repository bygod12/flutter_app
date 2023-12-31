import 'package:flutter/material.dart';

import '../../controllers/refeicoesController.dart';
import 'login/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final RefeicaoController refeicaoController = RefeicaoController();

  @override
  void initState() {
    super.initState();
    refeicaoController.getrefeicoess();

    //espera 3 segundos do splash
    Future.delayed(Duration(seconds: 3)).then((_) {
      //muda para a proxima tela
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));

    });
  }


  //constroe a tela do splash
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
