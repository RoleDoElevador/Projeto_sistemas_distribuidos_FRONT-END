import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        child:
            new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildHeader(),
          _retornarCampoForms("EMAIL", controladorEmail, _formKeyUser, false),
          _retornarCampoForms("SENHA", controladorSenha, _formKeyPassword, true),
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
        style:
            ElevatedButton.styleFrom(primary: Color.fromRGBO(96, 80, 136, 1)),
        onPressed: () {
          _validarAcesso();
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

  Future<void> _validarAcesso() async {
    if (_formKeyUser.currentState!.validate() ||
        _formKeyPassword.currentState!.validate()) {
      User usuario =
          new User(email: controladorEmail.text, senha: controladorSenha.text);
      User? usuarioEncontrado = await _bloc?.buscarUsuario(usuario);

      if (usuarioEncontrado?.email == controladorEmail.text &&
          usuarioEncontrado?.senha == controladorSenha.text) {
        Navigator.of(context).pushReplacementNamed(HomePage.ROUTE);
      } else {
        return _exibirDialogLoginIncorreto();
      }
    }
  }

  Future<void> _exibirDialogLoginIncorreto() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Usuário ou senha Incorreta", textAlign: TextAlign.center)),
          alignment: Alignment.centerRight,
          contentTextStyle: TextStyle(fontSize: 16, color: Colors.white),
          backgroundColor: Color.fromRGBO(96, 80, 136, 1),
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          content: Text(
            "O E-mail ou senha inserida está incorreto, tente novamente.", textAlign: TextAlign.center,),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              children: [
                Divider(
                  color: Colors.white,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Fechar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ],
            )
          ],
        ));
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

  Widget _retornarCampoForms(
      String nomeCampo, TextEditingController controlador, Key key, bool obscureText) {
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
                obscureText: obscureText,
                maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                maxLength: 100,
                cursorColor: Colors.transparent,
                decoration: new InputDecoration(
                  counterText: '',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '${nomeCampo} é obrigatório(a)';
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
