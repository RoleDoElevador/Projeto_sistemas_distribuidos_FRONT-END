import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/chatPet.dart';

class DetalhePet extends StatefulWidget {
  const DetalhePet({Key? key}) : super(key: key);
  static String ROUTE = '/detalhePet';

  @override
  State<DetalhePet> createState() => _DetalhePetState();
}

class _DetalhePetState extends State<DetalhePet> {
  CadastroPetCubit? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context)?.settings.arguments as CadastroPetCubit;
    return BlocProvider.value(
      value: _bloc!,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          title: Text(
            '${_bloc!.petSelecionado.nome}',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _fotoDoPet(),
          _historiaDoPet(),
          _descricaoPet(),
          _botaoEntrarEmContato(),
        ],
      ),
    );
  }

  Widget _fotoDoPet() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, int i) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 20,
                        //   child: IconButton(
                        //     padding: EdgeInsets.all(0),
                        //     icon: Icon(Icons.chevron_left,
                        //         color: Theme.of(context).primaryColor, size: 50),
                        //     onPressed: () => {},
                        //   ),
                        // ),
                        Center(
                            child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 2, right: 2),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: new ClipRRect(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(12)),
                            child: _bloc?.petSelecionado.imagem != null
                                ? new Image.memory(
                                    _bloc!.petSelecionado.imagem!,
                                    fit: BoxFit.fill,
                                  )
                                : new Container(),
                          ),
                        )),
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   padding: EdgeInsets.all(0),
                        //   height: MediaQuery.of(context).size.height,
                        //   width: 20,
                        //   child: IconButton(
                        //     padding: EdgeInsets.all(0),
                        //     icon: Icon(Icons.chevron_right,
                        //         color: Colors.black,
                        //         size: 50),
                        //     onPressed: () => {},
                        //   ),
                        // ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historiaDoPet() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
      decoration: BoxDecoration(
          color: Color(0xFFF3F1ED), borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.pets_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  'Sua História',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "${_bloc?.petSelecionado.historia}",
                textAlign: TextAlign.justify,
                maxLines: 5,
                overflow: TextOverflow.visible,
                style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _descricaoPet() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      decoration: BoxDecoration(
          color: Color(0xFFF3F1ED), borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.description_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 8),
                child: Text(
                  'Descrição',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.hourglass_full_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('${_bloc!.petSelecionado.idade}'),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.pets_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('${_bloc!.petSelecionado.raca}'),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('${_bloc!.petSelecionado.localizacao}'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _botaoEntrarEmContato() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 8),
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        onPressed: () {
          Navigator.of(context).pushNamed(ChatPet.ROUTE, arguments: _bloc);
        },
        child: Container(
          // width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  alignment: Alignment.center,
                  child: Text(
                    'Entrar em contato',
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
