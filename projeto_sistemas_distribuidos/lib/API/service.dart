import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet-retornoAPI.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/mensagem.dart';
import 'package:projeto_sistemas_distribuidos/login/model/user.dart';

class Service {
  String url = 'https://api-pets-prod.herokuapp.com/';

  Future<User?> CadastrarUsuario(User user) async {
    String _url = "${url}usuario/";

    try {
      var request = await http.post(Uri.parse(_url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(user.toMap()));

      User responseUser = User.fromJson(json.decode(request.body));
      return responseUser;
    } catch (e) {
      return null;
    }
  }

  Future<List<PetRetonoAPI>?> retonarListaDePets() async {
    String _url = "${url}pet/";

    try {
      List<PetRetonoAPI>? listaPets;
      var request = await http.get(
        Uri.parse(_url),
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
    String _url = "${url}pet/";

    try {
      var request = await http.post(Uri.parse(_url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(pet.toMap()));

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  Future<User?> verificarCredenciaisUsuario(User user) async {
    String _url = "${url}usuario/${user.email}";

    try {
      var request = await http.get(
        Uri.parse(_url),
        headers: {
          "content-type": "application/json",
        },
      );
      User response = User.fromJson(json.decode(request.body));

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deletePet(Pet pet) async {
    String _url = "${url}pet/";

    try {
      var request = await http.delete(
        Uri.parse(_url + pet.id.toString()),
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
    String _url = "${url}pet/";

    try {
      var request = await http.put(Uri.parse(_url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(pet.toMap()));

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  Future<List<Mensagem>?> listaMensagensRecebidas(String id) async {
    var _url = "${url}pets/mensagens/${id}";
    List<Mensagem>? listaMensagens;

    try {
      var request = await http.get(Uri.parse(_url));
      List<dynamic>? lista = jsonDecode(request.body);
      listaMensagens = lista!.map((i) => Mensagem.fromJson(i)).toList();
      return listaMensagens;
    } catch (e) {
      return null;
    }
  }


}
