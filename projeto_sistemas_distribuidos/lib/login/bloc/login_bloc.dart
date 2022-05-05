import 'package:bloc/bloc.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/login-cubit-action.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/login-cubit-model.dart';

class LoginCubit extends Cubit<LoginModel>
    implements LoginCubitAction {
  LoginCubit() : super(new LoginModel( users: []));

  @override
  void inicializarListaUsuarios() {
    // TODO: implement inicializarListaUsuarios
  }
}
