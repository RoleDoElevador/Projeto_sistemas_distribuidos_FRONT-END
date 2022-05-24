import 'dart:convert';


import 'dart:typed_data';

class inboxMensagem {
  String? id;
  String? idRemetente;
  String? idDestinatario;
  String? conteudo;
  String? data;
  String? nome;
  Uint8List? imagem;
  String? localizacao;

  inboxMensagem(
      {this.id,
      this.idRemetente,
      this.idDestinatario,
      this.conteudo,
      this.data,
      this.nome,
      this.imagem,
      this.localizacao
      });

  static inboxMensagem fromJson(Map<String, dynamic> json) {
    return inboxMensagem(
        id: json['id'],
        idRemetente: json['idRemetente'],
        idDestinatario: json['idDestinatario'],
        conteudo: json['conteudo'],
        data: json['data'],
        nome: json['nome'],
        imagem: base64.decode(json['imagem']),
        localizacao: json['localizacao']
        
        );
  }

  Map toJson() {
    return {
      'id': this.id,
      'idRemetente': this.idRemetente,
      'idDestinatario': this.idDestinatario,
      'conteudo': this.conteudo,
      'data': this.data,
      'nome': this.nome,
      'imagem': this.imagem,
      'localizacao':this.localizacao
    };
  }
}
