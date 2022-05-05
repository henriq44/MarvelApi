import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  @override
  void initState(){
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao){
    setState(() {
      isLogin = acao;
      if (isLogin){
        titulo = 'bem vindo';
        actionButton = 'login';
        toggleButton = 'ainda não possui conta? Cadastre-se agora';
      } else {
        titulo = 'Cire sua onta';
        actionButton = 'cadastrar';
        toggleButton = 'voltar ao login';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.only(top:100), 
      child: Form(key: formKey,
       child: Column(children:  [
         Text(
           titulo,
           style: const TextStyle(
             fontSize: 35,
             fontWeight: FontWeight.bold,
             letterSpacing: -1.5,
           ),
         )
       ]), ) , ),)
    );
  }
}