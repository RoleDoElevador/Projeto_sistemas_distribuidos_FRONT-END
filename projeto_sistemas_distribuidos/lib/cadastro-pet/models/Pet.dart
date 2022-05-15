

class Pet {
  String? nome;
  String? raca;
  String? localizacao;
  String? imagem;
  int? idade;
  int? codigo;
  String? historia;
  String? porte;
  String? idDono;

  Pet({this.nome, this.raca, this.localizacao, this.imagem, this.idade,this.codigo, this.historia, this.porte, this.idDono});

  static Pet fromJson(Map<String, dynamic> json) {
    return new Pet(
      nome: json['nome'],
      raca: json['raca'],
      localizacao: json['localizacao'],
      imagem: json['imagem'],
      idade: json['idade'],
      codigo: json['codigo'],
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
      "codigo": this.codigo,
      "historia": this.historia,
      "porte": this.porte,
      "idDono": this.idDono,
    };
  }
}
