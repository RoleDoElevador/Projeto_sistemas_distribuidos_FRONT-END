class User {
  int? codigo;
  String? nome;
  String? email;
  String? senha;

  User({this.codigo, this.nome, this.email, this.senha});

  static User fromJson(Map<String, dynamic> json) {
    return new User(
      codigo: json['codigo'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }

  Map toMap() {
    return {
      "codigo": this.codigo,
      "nome": this.nome,
      "email": this.email,
      "senha": this.senha
    };
  }
}
