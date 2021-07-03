import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //função para verificar o token (ela que vai ter os dados do usuario)
  Future<bool> verificarToken() async {
    //sempre chame o SharedPreference dentro de uma função
    //SharedPreferences = vai conferir se tem alguma chave chamada token dentro do app
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('token') == null) {
      return false;
    } else {
      return true;
    }
  }

  //a primeira coisa que o estado da tela vai fazer é verificar a função verificarToken
  @override
  void initState() {    
    super.initState();
    //só conseguimos colocar esse .then se tiparmos a função como Future
    //esse then vai guardar um true ou um false
    verificarToken().then((value) {
      if(value){
        //se for veradeiro vai para homepage(caso ja esteja logado)
        Navigator.of(context).pushReplacementNamed('/home_Page');
      }else {
        Navigator.of(context).pushReplacementNamed('/login_Page');        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //posso colocar uma imagem ou um container ao invez desse circular
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
