import 'package:flutter/material.dart';
import 'home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('Marvel App'),
      theme: ThemeData (primarySwatch: Colors.red),
      home: const MyHomePage(title: 'Marvel App',)
    );
  }
}