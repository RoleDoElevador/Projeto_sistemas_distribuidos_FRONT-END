import 'package:bloc/bloc.dart';
import 'package:projeto_sistemas_distribuidos/API/service.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/login-cubit-action.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/login-cubit-model.dart';
import 'package:projeto_sistemas_distribuidos/login/model/user.dart';

class LoginCubit extends Cubit<LoginModel>
    implements LoginCubitAction {
  LoginCubit() : super(new LoginModel( users: []));

  Service service = new Service();


  Future<User?> cadastrarUsuario(User user) async {
    User? _user = await service.CadastrarUsuario(user);
    return _user;
  }

  Future<User?> buscarUsuario(User user) async {
    User? _user = await service.verificarCredenciaisUsuario(user);
    return _user;
  }

  @override
  void inicializarListaUsuarios() {
    // TODO: implement inicializarListaUsuarios
  }
}
