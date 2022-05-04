import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';

class Service {
  String url = 'http://10.0.2.2:8080/pet/';

  Future<List<Pet>> retonarListaDePets() async {
    try {
      List<Pet>? listaPets;
      var request = await http.get(Uri.parse(url));
      List<dynamic>? lista = jsonDecode(request.body);
      listaPets = lista!.map((i) => Pet.fromJson(i)).toList();  
      return listaPets;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> cadastroPet(Pet pet) async {
    try {
      var request = await http.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(pet.toMap()));

      return request.statusCode >= 200 && request.statusCode <= 300;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deletePet(Pet pet) async {
    try {
      var request = await http.delete(
        Uri.parse(url + pet.codigo.toString()),
        headers: {
          "content-type": "application/json",
        },
      );

      return request.statusCode >= 200 && request.statusCode <= 300;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updatePet(Pet pet) async {
    try {
      var request = await http.put(Uri.parse(url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(pet.toMap()));

      return request.statusCode >= 200 && request.statusCode <= 300;
    } catch (e) {
      return false;
    }
  }
}
