import 'package:flutter/material.dart';
import 'package:marvel_test/auth_service.dart';
import 'package:provider/provider.dart';

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

  login() async {
    try {
      await context.read<AuthService>().login(email.text,senha.text);
    } on AuthException catch (e){
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

registrar() async {
    try {
      await context.read<AuthService>().login(email.text,senha.text);
    } on AuthException catch (e){
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.message)));
    }
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
         ),
         Padding(
           padding: const EdgeInsets.all(24),
           child: TextFormField(controller: email,
           decoration: const InputDecoration(
             border: OutlineInputBorder(),
             labelText: 'Email',
           ),
           keyboardType: TextInputType.emailAddress,
           validator: (value){
             if (value!.isEmpty){
               return 'Informe o email corretamnete!';
             }
             return null;
           },
           ),
           ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 12.00, horizontal: 24.00),
           child: TextFormField(
             controller: senha,
             obscureText: true,
             decoration: const InputDecoration(
               border: OutlineInputBorder(),
               labelText: 'senha',
             ),
             validator: (value) {
               if (value!.isEmpty){
                 return 'informa sua senha!';
               } else if (value.length <6){
                 return 'sua senha deve ter no mínimo 6 caracteres';
               }
               return null;
             },
           ),
           ),
           Padding(padding: const EdgeInsets.all(24.0),
           child: ElevatedButton(
             onPressed: () {
               if (formKey.currentState!.validate()){
                 if (isLogin){
                 login();
               } else{
                 registrar();
               }
               }
             },
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Icon(Icons.check),
                 Padding(padding: const EdgeInsets.all(16.0),
                 child: Text(
                   actionButton,
                   style: const TextStyle(fontSize: 20),
                 ),
                 )
               ],
             ),
           ),
           ),
           TextButton(onPressed: () => setFormAction (!isLogin), child: Text(toggleButton))
       ]), ) , ),)
    );
  }
}