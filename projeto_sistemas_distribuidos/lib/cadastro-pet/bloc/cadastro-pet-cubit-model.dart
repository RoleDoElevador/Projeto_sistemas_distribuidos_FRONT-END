import 'dart:io';

class CadastroPetModel {
   String? teste;
   File? fotoCadastroPet;


   CadastroPetModel(
      {
        this.teste,
        this.fotoCadastroPet,
      });

  CadastroPetModel patchState({
     String? teste,
    File? fotoCadastroPet,

  }) {
    return new CadastroPetModel(
      teste:  teste??this.teste,
        fotoCadastroPet: fotoCadastroPet??this.fotoCadastroPet,
    );
  }
}