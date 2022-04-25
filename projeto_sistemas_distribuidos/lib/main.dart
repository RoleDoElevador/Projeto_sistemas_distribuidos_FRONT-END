import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/cadastro-pet-form.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/chatPet.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/homePage.dart';

import 'cadastro-pet/components/detalhePet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF605088),
      ),
      home: HomePage(),
      routes: {
        DetalhePet.ROUTE: (context) => new DetalhePet(),
        ChatPet.ROUTE:(context) => new ChatPet()
      },
    );
  }
}
