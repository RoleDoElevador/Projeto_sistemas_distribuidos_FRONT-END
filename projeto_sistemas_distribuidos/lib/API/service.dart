import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';

class Service {
  String url = 'http://10.0.2.2:8080/user/';

  Future<List<Pet>> retonarListaDePets() async {
    try {
      var request = await http.get(Uri.parse(url));
      List<Pet> listaPets = (json.decode(request.body) as List)
          .map((e) => Pet.fromJson(e))
          .toList();
      return listaPets;
    } catch (e) {
      return [];
    }
  }
}
