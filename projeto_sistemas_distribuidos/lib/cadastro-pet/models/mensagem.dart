class Mensagem {
  String? codigo;
  String? conteudo;
  String? idRemetente;
  String? idDestinatario;
  String? data;
  String? autor;

  Mensagem(
      {this.codigo,
      this.conteudo,
      this.idRemetente,
      this.idDestinatario,
      this.data,
      this.autor
      });

  static Mensagem fromJson(Map<String, dynamic> json) {
    return new Mensagem(
      codigo: json['codigo'],
      conteudo: json['conteudo'],
      idRemetente: json['idRemetente'],
      idDestinatario: json['idDestinatario'],
      data: json['data'],
      autor: json['autor']
    );
  }

  Map toMap() {
    return {
      "codigo": this.codigo,
      "conteudo": this.conteudo,
      "idRemetente": this.idRemetente,
      "idDestinatario": this.idDestinatario,
      "data": this.data,
      "autor":this.autor
    };
  }
}
