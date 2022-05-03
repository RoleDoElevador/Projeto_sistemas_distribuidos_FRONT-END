import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({Key? key}) : super(key: key);
  static String ROUTE = "/cadastro-usuario";

  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  LoginCubit? _bloc;
  TextEditingController controladorNome = new TextEditingController();
  TextEditingController controladorEmail = new TextEditingController();
  TextEditingController controladorSenha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context)?.settings.arguments as LoginCubit;

    return BlocProvider.value(
      value: _bloc!,
      child: Scaffold(
          body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return new Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imagemFundoLogin.png"),
            fit: BoxFit.cover,
          )),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: new Column(children: [
          new Container(
            child: new Container(
              padding: const EdgeInsets.only(left: 8),
              child: new Image.asset(
                "assets/logo.png",
                scale: 1.5,
              ),
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text("OLX DE DOGUINHOS", style: TextStyle(fontSize: 24,
                color: const Color.fromRGBO(96, 80, 136, 1),
                fontWeight: FontWeight.bold)),
          ),
          _retornaCampoForms("NOME", controladorEmail),
          _retornaCampoForms("EMAIL", controladorEmail),
          _retornaCampoForms("SENHA", controladorSenha),
          new Container(
            padding: EdgeInsets.only(top: 8),
            child: new ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(96, 80, 136, 1)),
              onPressed: () {
              },
              child: new Text(
                "Cadastrar",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _retornaCampoForms(
      String nomeCampo, TextEditingController controlador) {
    return new Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      width: MediaQuery.of(context).size.width / 1.5,
      child: new Column(
        children: [
          new Container(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            alignment: Alignment.topLeft,
            child: new Text(
              nomeCampo,
              style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromRGBO(96, 80, 136, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(left: 8),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(12),
              color: const Color.fromRGBO(228, 226, 222, 1),
            ),
            child: new TextField(
              controller: controlador,
              cursorColor: Colors.transparent,
              decoration: new InputDecoration(
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
