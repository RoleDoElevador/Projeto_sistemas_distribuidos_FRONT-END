import 'dart:convert';
import 'dart:typed_data';

class Pet {
  String? nome;
  String? raca;
  String? localizacao;
  String? imagem;
  int? idade;
  int? codigo;

  Pet({this.nome, this.raca, this.localizacao, this.imagem, this.idade,this.codigo});

  static Pet fromJson(Map<String, dynamic> json) {
    return new Pet(
      nome: json['nome'],
      raca: json['raca'],
      localizacao: json['localizacao'],
      imagem: json['imagem'],
      idade: json['idade'],
      codigo: json['codigo']
    );
  }

  Map toMap() {
    return {
      "nome": this.nome,
      "raca": this.raca,
      "localizacao": this.localizacao,
      "imagem": this.imagem,
      "idade": this.idade,
      "codigo":this.codigo
    };
  }
}
