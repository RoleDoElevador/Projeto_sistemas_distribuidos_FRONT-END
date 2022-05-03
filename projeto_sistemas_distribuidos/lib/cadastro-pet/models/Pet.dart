import 'dart:typed_data';

class Pet {
  String? nome;
  String? raca;
  String? localizacao;
  Uint8List? imagem;

  Pet({this.nome, this.raca, this.localizacao, this.imagem});

  static Pet fromJson(Map<String, dynamic> json) {
    return new Pet(
        nome: json['nome'],
        raca: json['raca'],
        localizacao: json['localizacao'],
        imagem: json['imagem']);
  }
}
