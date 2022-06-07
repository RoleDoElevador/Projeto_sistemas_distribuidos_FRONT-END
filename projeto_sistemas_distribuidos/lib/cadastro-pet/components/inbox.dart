import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit-model.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/chatPet.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);
  static String ROUTE = "/inbox";

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  CadastroPetCubit? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context)?.settings.arguments as CadastroPetCubit;
    _bloc?.buscarMensagensInbox(_bloc!.idUsuario);
    //ceaa3009-bd00-46e8-9257-3617c91124d8

    return new BlocProvider.value(
      value: _bloc!,
      child: new Scaffold(
          appBar: new PreferredSize(
            child: _buildAppBar(),
            preferredSize: Size.fromHeight(60),
          ),
          body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return new BlocBuilder<CadastroPetCubit, CadastroPetModel>(
      builder: (context, state) => _buildListViewMensagens(),
    );
  }

  Widget _buildListViewMensagens() {
    return new BlocBuilder<CadastroPetCubit, CadastroPetModel>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              new Container(
                padding: const EdgeInsets.only(top: 8, left: 16),
                alignment: Alignment.centerLeft,
                child: Text("Mensagens",
                    style: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(96, 80, 136, 1))),
              ),
              Expanded(
                child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: 8),
                  itemCount: state.listaMensagensInbox?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new SingleChildScrollView(
                      padding: EdgeInsets.only(top: 4),
                      child: Column(
                        children: [
                          new ListTile(
                            onTap: () {
                              _bloc?.mensagemSelecionada =
                                  state.listaMensagensInbox![index];
                              Navigator.of(context)
                                  .pushNamed(ChatPet.ROUTE, arguments: _bloc);
                            },
                            leading: CircleAvatar(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: ClipOval(
                                  child: Image.memory(
                                    state.listaMensagensInbox![index].imagem ?? Uint8List(1),
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                )),
                            title: new Text(
                                "${state.listaMensagensInbox?[index].nome}",
                                style: new TextStyle(
                                    fontFamily: 'Roboto-Regular.ttf',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromRGBO(96, 80, 136, 1))),
                            subtitle: new Text(
                                "${state.listaMensagensInbox?[index].conteudo}"),
                          ),
                          Divider()
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
      elevation: 0,
      leading: new GestureDetector(
        child: new Icon(
          Icons.arrow_back_ios_rounded,
          color: const Color.fromRGBO(96, 80, 136, 1),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: Container(
        padding: EdgeInsets.only(top: 4),
        child: new Text(
          'INBOX',
          style: const TextStyle(
              fontFamily: 'Roboto-Regular.ttf',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(96, 80, 136, 1)),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
