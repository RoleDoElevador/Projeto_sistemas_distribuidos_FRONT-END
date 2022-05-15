import 'dart:io';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet-retornoAPI.dart';

class CadastroPetModel {
   File? fotoCadastroPet;
   List<PetRetonoAPI>? listaPets;


   CadastroPetModel(
      {
        this.fotoCadastroPet,
        this.listaPets,
      });

  CadastroPetModel patchState({
    File? fotoCadastroPet,
    List<PetRetonoAPI>? listaPets,

  }) {
    return new CadastroPetModel(
        fotoCadastroPet: fotoCadastroPet??this.fotoCadastroPet,
      listaPets: listaPets??this.listaPets,
    );
  }
}