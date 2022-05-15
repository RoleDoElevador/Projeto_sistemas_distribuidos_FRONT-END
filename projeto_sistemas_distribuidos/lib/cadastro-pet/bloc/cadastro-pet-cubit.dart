import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_sistemas_distribuidos/API/service.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet-retornoAPI.dart';
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
  String? historiaPet = '';
  Service service = new Service();
  Uint8List imagemPet = Uint8List(0);
  PetRetonoAPI petSelecionado = PetRetonoAPI();
  String imagemPetBase64 = '';


  void inicializarListaPets() async {
      service.retonarListaDePets().then(
            (pets) =>
            emit(
              state.patchState(listaPets: pets),
            ),
      );
    }

  @override
  Future abrirGaleria() async {
      try {
        final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

        final imageTemp = File(pickedFile!.path);
        Uint8List imagemGaleria = await imageTemp.readAsBytes();
        String _imagemBase64 = base64Encode(imagemGaleria);
        imagemPetBase64 = _imagemBase64;

        emit(state.patchState(fotoCadastroPet: imageTemp));
      } catch (e) {
        print('deu ruim: $e');
      }
    }

  @override
  void cadastrarPet(BuildContext context, Pet pet) {


    service.cadastroPet(pet);
    print(pet);
  }

}