

class CadastroPetModel {
   String? teste;


  CadastroPetModel(
      {
        this.teste
      });

  CadastroPetModel patchState({
     String? teste,

  }) {
    return new CadastroPetModel(
      teste:  teste??this.teste

    );
  }
}