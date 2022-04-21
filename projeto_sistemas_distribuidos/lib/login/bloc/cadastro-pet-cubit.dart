
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/login/bloc/cadastro-pet-cubit-model.dart';
import 'cadastro-pet-cubit-action.dart';

class LoginCubit extends Cubit<LoginModel>
    implements LoginCubitAction {
  LoginCubit()
      : super(new LoginModel(
          teste: "",
        ));


  String teste = 'RS 1800,00';





}
