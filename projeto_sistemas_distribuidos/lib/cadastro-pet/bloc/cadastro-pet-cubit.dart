import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'cadastro-pet-cubit-action.dart';
import 'cadastro-pet-cubit-model.dart';

class CadastroPetCubit extends Cubit<CadastroPetModel>
    implements CadastroPetCubitAction {
  CadastroPetCubit()
      : super(new CadastroPetModel(
          teste: '',
          fotoCadastroPet: File(''),
        ));

  String teste = 'THANOS';

  Future abrirGaleria() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemp = File(pickedFile!.path);

      emit(state.patchState(fotoCadastroPet: imageTemp));
    } catch (e) {
      print('deu ruim: $e');
    }
  }
}
