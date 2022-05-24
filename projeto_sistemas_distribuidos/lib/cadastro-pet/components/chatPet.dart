import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit-model.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/cadastro-pet-form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/mensagem.dart';
import 'package:intl/intl.dart';

class ChatPet extends StatefulWidget {
  const ChatPet({Key? key}) : super(key: key);
  static String ROUTE = "/chatPet";

  @override
  State<ChatPet> createState() => _ChatPetState();
}

class _ChatPetState extends State<ChatPet> {
  TextEditingController _messageController = TextEditingController();
  CadastroPetCubit? _bloc;
  bool buscouLista = false;
  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context)?.settings.arguments as CadastroPetCubit;
    if (!buscouLista) {
      _bloc?.buscarMensagens(
          _bloc!.idUsuario, _bloc!.mensagemSelecionada.idDestinatario!);
      buscouLista = true;
    }

    return BlocProvider.value(
      value: _bloc!,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        padding: EdgeInsets.only(top: 4, bottom: 8),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                _bloc?.state.listaMensagensTrocadas = [];
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Theme.of(context).primaryColor,
                size: 25,
              )),
          title: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_bloc!.mensagemSelecionada.nome}',
                style: TextStyle(color: Colors.black),
              ),
              Text('${_bloc!.mensagemSelecionada.localizacao}',
                  style: TextStyle(color: Colors.grey))
            ],
          ),
          centerTitle: true,
          actions: [
            Container(
              padding: EdgeInsets.only(right: 16),
              child: CircleAvatar(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.blue,
                  radius: 30,
                  child: ClipOval(
                    child: Image.memory(
                      _bloc!.mensagemSelecionada.imagem!,
                      fit: BoxFit.fill,
                      width: 100,
                      height: 70,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CadastroPetCubit, CadastroPetModel>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin:
                      EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                     // reverse: true,
                      itemCount: state.listaMensagensTrocadas?.length == null
                          ? 0
                          : state.listaMensagensTrocadas?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Row(
                            //alinhar as mensagens por aqui
                            mainAxisAlignment: state
                                        .listaMensagensTrocadas?[index]
                                        .idRemetente ==
                                    _bloc?.idUsuario
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: state.listaMensagensTrocadas?[index]
                                                .idRemetente ==
                                            _bloc?.idUsuario?
                                        Theme.of(context).primaryColor:
                                       Colors.grey[600],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      '${state.listaMensagensTrocadas?[index].conteudo}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
              _bottomMessage()
            ],
          ),
        );
      },
    );
  }

  Widget _bottomMessage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),

      //color: Colors.blue,
      child: Row(
        children: [
          // Expanded(child: Container()),
          Flexible(
              flex: 5,
              child: new Container(
                padding: EdgeInsets.only(left: 16),
                margin: EdgeInsets.only(right: 8, left: 16),
                //height: 40,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.grey[700]!,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  maxLines: null,
                  controller: _messageController,
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintText: 'Digite sua mensagem...',
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                  ),
                ),
              )),
          Expanded(
            child: Container(
              height: 40,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: IconButton(
                onPressed: () {
                  _bloc?.realizarFluxoCompletoEnvioMensagem(
                      _messageController.text);
                  _messageController.clear();
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
