import 'dart:js';
import 'package:flutter/material.dart';
import 'package:marvel_test/auth_service.dart';
import 'app_widget.dart';
import 'home_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.start();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ]
    )
    
  );
}

