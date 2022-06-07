import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/login/model/user.dart';
import 'package:projeto_sistemas_distribuidos/utils/loading.dart';


class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({Key? key}) : super(key: key);
  static String ROUTE = "/cadastro-usuario";

  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  LoginCubit? _bloc;
  final _formKeyUser = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
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
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 32),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 1.6,
          width: MediaQuery.of(context).size.width / 1.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: new Column(children: [
            new Container(
              padding: EdgeInsets.only(bottom: 8),
              child: new Image.asset(
                "assets/logo_roxo.png",
                scale: 1.8,
              ),
            ),
            _retornarCampoForms(_formKeyUser ,"NOME", controladorNome, false),
            _retornarCampoForms(_formKeyEmail, "EMAIL", controladorEmail, false),
            _retornarCampoForms(_formKeyPassword, "SENHA", controladorSenha, true),
            new Container(
              padding: EdgeInsets.only(top: 8),
              child: new ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(96, 80, 136, 1)),
                onPressed: () {
                  _validarCadastro();
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
      ),
    );
  }

  Future<void> _validarCadastro() async {
    if (_formKeyUser.currentState!.validate() ||
        _formKeyPassword.currentState!.validate() || _formKeyEmail.currentState!.validate()) {
      LoadingDialog().showLoading(context);

      final User user = new User(nome: controladorNome.text, email: controladorEmail.text, senha: controladorSenha.text);

      final User? usuariocadastrado = await _bloc?.cadastrarUsuario(user);

      LoadingDialog().dismiss(context);
      if (usuariocadastrado != null){
        _exibirDialogSucesso();
      } else {
         return _exibirDialogErroAoCadastrarUser();
      }
    }
  }

  Widget _retornarCampoForms(Key key,
      String nomeCampo, TextEditingController controlador, bool obscureText) {
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
                maxLength: 100,
                obscureText: obscureText,
                controller: controlador,
                cursorColor: Colors.transparent,
                decoration: new InputDecoration(
                  counterText: '',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '${nomeCampo} é obrigatório';
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

  Future _exibirDialogErroAoCadastrarUser() async {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("E-mail Existente", textAlign: TextAlign.center)),
          alignment: Alignment.centerRight,
          backgroundColor: Color.fromRGBO(96, 80, 136, 1),
          contentTextStyle: TextStyle(fontSize: 16, color: Colors.black),
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          content: Text(
              "Já existe um cadastro com o E-mail inserido, tente novamente mais tarde.", textAlign: TextAlign.center,),
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

  Future _exibirDialogSucesso() async {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Cadastrado com Sucesso!", textAlign: TextAlign.center)),
          alignment: Alignment.centerRight,
          contentTextStyle: TextStyle(fontSize: 16, color: Colors.black),
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          content: Text(
            "Usuário cadastrado com Sucesso! \n Agora, basta acessar a tela de login e entrar.", textAlign: TextAlign.center,),
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
}
