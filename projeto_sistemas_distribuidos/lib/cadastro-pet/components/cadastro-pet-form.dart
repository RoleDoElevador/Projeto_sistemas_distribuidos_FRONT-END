import 'package:flutter/material.dart';

class CadastroPet extends StatefulWidget {
  const CadastroPet({Key? key}) : super(key: key);

  @override
  _CadastroPetState createState() => _CadastroPetState();
}

class _CadastroPetState extends State<CadastroPet> {
  TextEditingController controladorNomePet = new TextEditingController();
  TextEditingController controladoridadePet = new TextEditingController();
  TextEditingController controladorRacaPet = new TextEditingController();
  TextEditingController controladorLocalizacaoPet = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 24),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Image.asset(
                        "assets/logo.png",
                        scale: 1.5,
                      ),
                    ),
                    Text(
                      'CADASTRE SEU PET',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(96, 80, 136, 1)),
                    ),
                  ],
                ),
              ),
              _retornaCampoForms("NOME", controladorNomePet),
              _retornaCampoForms("IDADE", controladoridadePet),
              _retornaCampoForms("RAÇA", controladorRacaPet),
              _retornaCampoForms("LOCALIZAÇÃO", controladorLocalizacaoPet),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Anexar uma foto",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(96, 80, 136, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.camera)
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  _retornaCampoForms(String nomeCampo, TextEditingController controlador) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      width: MediaQuery.of(context).size.width / 1.2,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              nomeCampo,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(96, 80, 136, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color.fromRGBO(228, 226, 222, 1),
            ),
            child: TextField(
              controller: controlador,
              cursorColor: Colors.transparent,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
