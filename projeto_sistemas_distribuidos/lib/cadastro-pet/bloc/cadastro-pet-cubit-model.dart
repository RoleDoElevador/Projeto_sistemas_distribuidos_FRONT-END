

class CadastroPetModel {
   String? teste;


  CadastroPetModel(
      {
        this.teste
      });

  CadastroPetModel patchState({
     String? valorNaConta,

  }) {
    return new CadastroPetModel(
      teste:  teste??this.teste

    );
  }
}