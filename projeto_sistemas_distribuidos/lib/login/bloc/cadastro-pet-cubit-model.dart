

class LoginModel {
   String? teste;


  LoginModel(
      {
        this.teste
      });

  LoginModel patchState({
     String? valorNaConta,

  }) {
    return new LoginModel(
      teste:  teste??this.teste

    );
  }
}