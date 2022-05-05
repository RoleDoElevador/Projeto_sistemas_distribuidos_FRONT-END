import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet-retornoAPI.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';

class Service {
  String url = 'https://api-pets-prod.herokuapp.com/pet/';

  Future<List<PetRetonoAPI>?> retonarListaDePets() async {
    try {
      List<PetRetonoAPI>? listaPets;
      var request = await http.get(
        Uri.parse(url),
        headers: {
          "content-type": "application/json",
        },
      );
      List<dynamic>? lista = jsonDecode(request.body);
      listaPets = lista!.map((i) => PetRetonoAPI.fromJson(i)).toList();
      return listaPets;
    } catch (e) {
      return null;
    }
  }

  Future<bool> cadastroPet(Pet pet) async {
    try {
      var teste = json.encode(pet.toMap());

      var request = await http.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(pet.toMap()));

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
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

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
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

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
      return false;
    }
  }
}
