import 'dart:io';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet-retornoAPI.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/inbox-mensagem.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/mensagem.dart';

class CadastroPetModel {
  File? fotoCadastroPet;
  List<PetRetonoAPI>? listaPets;
  List<PetRetonoAPI>? listaPetsBarraPesquisa;
  List<Mensagem>? listaMensagensTrocadas;
  List<inboxMensagem>? listaMensagensInbox;

  CadastroPetModel({
    this.fotoCadastroPet,
    this.listaPets,
    this.listaPetsBarraPesquisa,
    this.listaMensagensTrocadas,
    this.listaMensagensInbox,
  });

  CadastroPetModel patchState({
    File? fotoCadastroPet,
    List<PetRetonoAPI>? listaPets,
    List<PetRetonoAPI>? listaPetsBarraPesquisa,
    List<Mensagem>? listaMensagensTrocadas,
    List<inboxMensagem>? listaMensagensInbox,
  }) {
    return new CadastroPetModel(
      fotoCadastroPet: fotoCadastroPet ?? this.fotoCadastroPet,
      listaPets: listaPets ?? this.listaPets,
      listaPetsBarraPesquisa: listaPetsBarraPesquisa ?? this.listaPetsBarraPesquisa,
      listaMensagensTrocadas:
          listaMensagensTrocadas ?? this.listaMensagensTrocadas,
      listaMensagensInbox: listaMensagensInbox ?? this.listaMensagensInbox,
    );
  }
}
