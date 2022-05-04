import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';

abstract class CadastroPetCubitAction {
  void salvarCadastroPet(BuildContext context, Pet pet) {}
}