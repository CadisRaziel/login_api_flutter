import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //função para deslogar e voltar para tela de login
  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Home Page',
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () async {
              bool saiu = await sair();
              if(saiu) {
                Navigator.of(context).pushReplacementNamed('/splash_Screen');
              }
            },
            child: Text('sair'),
          )
        ],
      ),
    );
  }
}
