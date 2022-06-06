import 'package:flutter/material.dart';

class SobreNos extends StatefulWidget {
  const SobreNos({Key? key}) : super(key: key);
  static String ROUTE = "/sobre-nos";

  @override
  State<SobreNos> createState() => _SobreNosState();
}

class _SobreNosState extends State<SobreNos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 180,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 32,
            color: Color.fromRGBO(96, 80, 136, 1),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Image.asset("assets/logo_roxo.png"),
        backgroundColor: Colors.white,
        actions: [
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 1.8,
              padding: EdgeInsets.only(left: 12, right: 12),
              margin: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                color: Color.fromRGBO(96, 80, 136, 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Text("SOBRE NÓS", style: TextStyle( color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 2)),
                  Text("Somos um grupo de estudantes universitários que visa promover uma maneira mais organizada e intuitiva para se adotar pets."
                      " A aplicação foi desenvolvida no ano de 2022 e conta exclusivamente com a participação da comunidade,"
                      " onde tal poderá se registrar, cadastrar a doação ou até mesmo adotar o novo membro da família,"
                      " tudo isso sem sair de casa e de forma totalmente gratuita.A aplicação fica responsável por promover a comunicação entre o doador"
                      " e a pessoa que vai adotar, eximindo quaisquer responsabilidades legais quanto ao processo de doação e encontro entre as partes.",
                      style: TextStyle(color: Colors.white, fontSize: 15, letterSpacing: 1.5, fontWeight: FontWeight.w400, height: 1.5), textAlign: TextAlign.justify,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
