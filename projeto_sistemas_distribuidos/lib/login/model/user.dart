import 'package:projeto_sistemas_distribuidos/API/servicePet.dart';

class User {
  String? id;
  String? nome;
  String? email;
  String? senha;

  User({this.id, this.nome, this.email, this.senha});

  static User fromJson(Map<String, dynamic> json) {
    return new User(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }

  Map toMap() {
    return {
      "id": this.id,
      "nome": this.nome,
      "email": this.email,
      "senha": this.senha
    };
  }
}
