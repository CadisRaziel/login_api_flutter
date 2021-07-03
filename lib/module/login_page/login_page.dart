import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //è com esses finals se vamos saber se ele esta colocando dados errados ou não

  //_formKey = Vai ser responsavel de dizer se o usuario digitou algum dado errado ou não
  final _formKey = GlobalKey<FormState>();

  //_emailController = vai receber os dados do usuario de email
  final _emailController = TextEditingController();

  //_passwordController = vai receber os dados do usuario de email
  final _passwordController = TextEditingController();

  //Esse SharedPreference vai setar nosso token e se deu certo para nosso usuario ver
  //o token que esta na splashScreen que vai ser responsavel por gerenciar
  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://minhasapis.com.br/login/');
    var response = await http.post(url, body: {
      'username': _emailController.text,
      'password': _passwordController.text
    });

    if (response.statusCode == 200) {
      await sharedPreferences.setString('token', 'Token ${jsonDecode(response.body)['token']}');
      return true;
    } else {
      return false;
    }
  }

  //SnackBar
  final snackBar = SnackBar(
    content: Text('E-mail ou senha são inválidos', textAlign: TextAlign.center),
    backgroundColor: Colors.redAccent, duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      //o Form sem a key nós não conseguimos criar ele e controllar o estado
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Por favor, digite o seu e-mail';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_emailController.text)) {
                    return 'Por favor, digite um e-mail correto';
                  }

                  //se caso não apresentar nenhum dos erros acima, ele não vai aparesentar nenhuma mensagem de erro ao usuario
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (senha) {
                  if (senha == null || senha.isEmpty) {
                    return 'Por favor, digite sua senha';
                  } else if (senha.length <= 5) {
                    return 'Por favor, digite uma senha maior que 6 caracteres';
                  }
                  //se caso não apresentar nenhum dos erros acima, ele não vai aparesentar nenhuma mensagem de erro ao usuario
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  //se der certo, fechar o teclado
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  //_formKey.currentState!.validate() = só vai aceitar apertar o botão se os estados acima /\ estiverem validos !
                  if (_formKey.currentState!.validate()) {
                    bool deuCerto = await login();

                    //a hora que passar para proxima tela, ele fecha o teclado
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    if (deuCerto) {
                      Navigator.of(context).pushReplacementNamed('/home_Page');
                    } else {
                      _passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                child: Text('Entrar'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

//Expressão para conferir se o email é regular e esta correto
/*
else if (!RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(_emailController.text)) {
       return 'Por favor, digite um e-mail correto';
*/
