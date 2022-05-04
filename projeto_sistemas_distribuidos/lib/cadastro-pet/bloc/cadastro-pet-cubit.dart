import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_sistemas_distribuidos/API/service.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';
import 'cadastro-pet-cubit-action.dart';
import 'cadastro-pet-cubit-model.dart';

class CadastroPetCubit extends Cubit<CadastroPetModel>
    implements CadastroPetCubitAction {
  CadastroPetCubit()
      : super(new CadastroPetModel(
          fotoCadastroPet: File(''),
          listaPets: [],
        ));

  String? nomePet = '';
  int idadePet = 0;
  String? racaPet = '';
  String? localizacaoPet = '';
  Service service = new Service();
  Uint8List imagemPet = Uint8List(0);


  void inicializarListaPets(Service service) async {
    service.retonarListaDePets().then(
          (pets) => emit(
        state.patchState(
             listaPets: pets),
      ),
    );
  }


  void salvarCadastroPet( BuildContext context, Pet pet) {
    service.cadastroPet(pet);
  }

  Future tratarImagemPet(File imagem) async {
    imagemPet = await imagem.readAsBytes();

    String imagemTratada = imagemPet.toString();

    return imagemTratada;
  }

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
