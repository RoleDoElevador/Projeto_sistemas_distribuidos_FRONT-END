class User {
  int? codigo;
  String? conteudo;
  int? idRemetente;
  int? idDestinatario;
  String? data;

  User({this.codigo, this.conteudo, this.idRemetente, this.idDestinatario, this.data});

  static User fromJson(Map<String, dynamic> json) {
    return new User(
      codigo: json['codigo'],
      conteudo: json['conteudo'],
      idRemetente: json['idRemetente'],
      idDestinatario: json['idDestinatario'],
      data: json['data'],
    );
  }

  Map toMap() {
    return {
      "codigo": this.codigo,
      "conteudo": this.conteudo,
      "idRemetente": this.idRemetente,
      "idDestinatario": this.idDestinatario,
      "data": this.data
    };
  }
}