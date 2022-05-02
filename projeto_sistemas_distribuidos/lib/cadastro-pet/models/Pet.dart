import 'dart:typed_data';

class Pet {
  String? nome;
  List<String>? raca;
  String? localizacao;
  Uint8List? imagem;

  Pet({this.nome, this.raca, this.localizacao, this.imagem});

  static Pet fromJson(Map<String, dynamic> json) {
    return new Pet(
        nome: json['nome'],
        raca: (json['raca'] != null)
            ? (json['raca'] as List).map((e) => Pet.fromJson(e)).toList().cast() // nao sei se isso aqui vai funcionar
            : [],
   
        localizacao: json['localizacao'],
        imagem: json['imagem']);
  }
}
