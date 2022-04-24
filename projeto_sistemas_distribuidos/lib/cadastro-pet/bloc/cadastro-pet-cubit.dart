import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cadastro-pet-cubit-action.dart';
import 'cadastro-pet-cubit-model.dart';

class CadastroPetCubit extends Cubit<CadastroPetModel>
    implements CadastroPetCubitAction {
  CadastroPetCubit()
      : super(new CadastroPetModel(
          teste: '',
        ));


  String teste = 'THANOS';





}
