import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/API/servicePet.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/homePage.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/login/components/cadastroUsuario.dart';
import 'package:projeto_sistemas_distribuidos/login/model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String ROUTE = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit? _bloc;
  TextEditingController controladorEmail = new TextEditingController();
  TextEditingController controladorSenha = new TextEditingController();
  final _formKeyUser = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    _bloc = LoginCubit();

    return BlocProvider(
      create: (BuildContext context) {
        _bloc = LoginCubit();

        return _bloc!;
      },
      child: Scaffold(body: _buildBody()),
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
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          _buildHeader(),
          _retornaCampoForms("EMAIL", controladorEmail, _formKeyUser),
          _retornaCampoForms("SENHA", controladorSenha, _formKeyPassword),
          _retornaBotaoEntrar(),
          _retornaBotaoCadastro(),
        ]),
      ),
    );
  }

  _retornaBotaoEntrar() {
    return new Container(
      padding: EdgeInsets.only(top: 16),
      child: new ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(96, 80, 136, 1)),
        onPressed: () async {
          if (_formKeyUser.currentState!.validate() ||
              _formKeyPassword.currentState!.validate()) {

            User usuario = new User(email: controladorEmail.text, senha: controladorSenha.text);

            User? usuarioEncontrado = await _bloc?.buscarUsuario(usuario);

            if(usuarioEncontrado?.email == controladorEmail.text && usuarioEncontrado?.senha == controladorSenha.text){
              Navigator.of(context).pushReplacementNamed(HomePage.ROUTE);
            } else {
             print("DEU RUIM");
            }
          }
          //await service.retonarListaDePets();
        },
        child: new Text(
          "ENTRAR",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _retornaBotaoCadastro() {
    return new Container(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CadastroUsuario.ROUTE, arguments: _bloc);
        },
        child: Text(
          "Não possui cadastro? Cadastre-se aqui!!",
          style: TextStyle(
              color: const Color.fromRGBO(96, 80, 136, 1),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  Widget _retornaCampoForms(
      String nomeCampo, TextEditingController controlador, Key key) {
    return Form(
      key: key,
      child: new Container(
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
              child: new TextFormField(
                controller: controlador,
                cursorColor: Colors.transparent,
                decoration: new InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'O usuário é obrigatório';
                  } else
                    return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
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
          child: Text("ADOPTIONEW",
              style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromRGBO(96, 80, 136, 1),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
