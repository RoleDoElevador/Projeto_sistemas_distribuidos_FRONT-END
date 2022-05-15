

import 'dart:convert';
import 'dart:typed_data';

class PetRetonoAPI {
  String? nome;
  String? raca;
  String? localizacao;
  Uint8List? imagem;
  int? idade;
  String? id;
  String? historia;
  String? porte;
  String? idDono;

  PetRetonoAPI({this.nome, this.raca, this.localizacao, this.imagem, this.idade,this.id, this.historia, this.porte, this.idDono});

  static PetRetonoAPI fromJson(Map<String, dynamic> json) {
    return new PetRetonoAPI(
      nome: json['nome'],
      raca: json['raca'],
      localizacao: json['localizacao'],
      imagem: base64.decode(json['imagem']),
      idade: json['idade'],
      id: json['id'],
        historia: json['historia'],
        porte:  json['porte'],
        idDono: json['idDono']
    );
  }

  Map toMap() {
    return {
      "nome": this.nome,
      "raca": this.raca,
      "localizacao": this.localizacao,
      "imagem": this.imagem,
      "idade": this.idade,
      "id":this.id,
      "historia": this.historia,
      "porte": this.porte,
      "idDono": this.idDono
    };
  }
}
