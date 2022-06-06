import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:projeto_sistemas_distribuidos/API/service.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet-retornoAPI.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/inbox-mensagem.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/mensagem.dart';
import 'cadastro-pet-cubit-action.dart';
import 'cadastro-pet-cubit-model.dart';

class CadastroPetCubit extends Cubit<CadastroPetModel>
    implements CadastroPetCubitAction {
  CadastroPetCubit()
      : super(new CadastroPetModel(
          fotoCadastroPet: File(''),
          listaPets: [],
          listaMensagensTrocadas: [],
          listaMensagensInbox: [],
        ));

  String? nomePet = '';
  int idadePet = 0;
  String? racaPet = '';
  String? localizacaoPet = '';
  String? historiaPet = '';
  Service service = new Service();
  Uint8List imagemPet = Uint8List(0);
  PetRetonoAPI petSelecionado = PetRetonoAPI();
  String imagemPetBase64 = '';

  String idUsuario =
      'ceaa3009-bd00-46e8-9257-3617c91124d8'; //alterar para pegar quando fizer login

  inboxMensagem mensagemSelecionada = inboxMensagem();

  void inicializarListaPets() async {
    service.retonarListaDePets().then(
          (pets) => emit(
            state.patchState(listaPets: pets, listaPetsBarraPesquisa: pets),
          ),
        );
  }

  @override
  Future abrirGaleria() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemp = File(pickedFile!.path);
      Uint8List imagemGaleria = await imageTemp.readAsBytes();
      String _imagemBase64 = base64Encode(imagemGaleria);
      imagemPetBase64 = _imagemBase64;

      emit(state.patchState(fotoCadastroPet: imageTemp));
    } catch (e) {
      print('deu ruim: $e');
    }
  }

  @override
  void cadastrarPet(BuildContext context, Pet pet) {
    service.cadastroPet(pet);
    print(pet);
  }

  void buscarMensagensInbox(String idDestinatario) async {
    List<inboxMensagem>? _listaMensagensInbox =
        await service.listaInboxMensagens(idDestinatario);
    emit(state.patchState(listaMensagensInbox: _listaMensagensInbox));
  }

  Future<List<Mensagem>?> buscarMensagens(
      String idUsuario, String idPet) async {
    List<Mensagem>? _listaMensagens =
        await service.listaMensagensTrocadas(idUsuario, idPet);

    emit(state.patchState(listaMensagensTrocadas: _listaMensagens));
    return _listaMensagens;
  }

  Future<bool> enviarMensagem(Mensagem mensagem) async {
    bool request = await service.enviarMensagem(mensagem);

    return request;
  }

  void realizarFluxoCompletoEnvioMensagem(String conteudo) async {
    if (conteudo.isNotEmpty) {
      String autor;
      if (mensagemSelecionada.idDestinatario == idUsuario) {
        autor = "dono";
      } else {
        autor = "adotador";
      }
      await enviarMensagem(
        Mensagem(
            codigo: null,
            data: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
            conteudo: conteudo,
            idRemetente: idUsuario,
            idDestinatario: mensagemSelecionada.idDestinatario,
            autor: autor),
      );
      List<Mensagem>? _listaMensagensAtualizada =
          await buscarMensagens(idUsuario, mensagemSelecionada.idDestinatario!);

      _listaMensagensAtualizada!.reversed;

      emit(state.patchState(listaMensagensTrocadas: _listaMensagensAtualizada));
    }
  }
}
