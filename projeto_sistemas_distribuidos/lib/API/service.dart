import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';

class Service {
  String url = 'http://10.0.2.2:8080/user/';

  Future<List<Pet>> retonarListaDePets() async {
    try {
      List<Pet>? listaPets;
      var request = await http.get(Uri.parse(url));
      List<dynamic>? lista = jsonDecode(request.body);
      listaPets = lista!.map((i) => Pet.fromJson(i)).toList();
      var teste = "";
      return listaPets;
    } catch (e) {
      return [];
    }
  }

  Future<bool> cadastroPet(Pet pet) async {
    try {
      var request = await http.post(Uri.parse(url), body: pet);
      return request.statusCode >= 200 && request.statusCode <= 300;
    } catch (e) {
      return false;
    }
  }
}
