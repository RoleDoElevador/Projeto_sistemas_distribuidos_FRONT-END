import 'dart:io';

import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';

class CadastroPetModel {
   File? fotoCadastroPet;
   List<Pet>? listaPets;


   CadastroPetModel(
      {
        this.fotoCadastroPet,
        this.listaPets,
      });

  CadastroPetModel patchState({
    File? fotoCadastroPet,
    List<Pet>? listaPets,

  }) {
    return new CadastroPetModel(
        fotoCadastroPet: fotoCadastroPet??this.fotoCadastroPet,
      listaPets: listaPets??this.listaPets,
    );
  }
}