import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/API/service.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit-model.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/cadastro-pet-form.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/detalhePet.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet-retornoAPI.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/models/Pet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String ROUTE = "/home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CadastroPetCubit? _bloc;

  @override
  Widget build(BuildContext context) {

    return new BlocProvider(
      create: (BuildContext context) {
        _bloc = CadastroPetCubit();
        _bloc!.inicializarListaPets();
        return _bloc!;
      },
      child: new BlocBuilder<CadastroPetCubit, CadastroPetModel>(
        builder: (context, state) {
          return new Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: _buildAppBar(),
            ),
            drawer: _buildDrawer(),
            extendBodyBehindAppBar: false,
            body: _buildBody(),
            floatingActionButton: Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(96, 80, 136, 1),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CadastroPet.ROUTE, arguments: _bloc);
                },
                child: Icon(Icons.add, size: 28),
                elevation: 1,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CadastroPetCubit, CadastroPetModel>(
      builder: (context, state) {
        if (state.listaPets!.isNotEmpty) {
          return _buildGridViewPets(state.listaPets);
        } else {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 32, right: 32),
            width: MediaQuery.of(context).size.width / 0.5,
            child: Text(
              "Atualmente, não possuimos nenhum animal disponível para adoção.",
            ),
          );
        }
      },
    );
  }


  Widget _buildGridViewPets(List<PetRetonoAPI>? listaPets) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBarraPesquisa(),
          new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
              padding: EdgeInsets.only(top: 20, bottom: 8),
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      mainAxisExtent: 260),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  itemCount: listaPets?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {

                        _bloc!.petSelecionado = listaPets![index];

                        Navigator.pushNamed(context, DetalhePet.ROUTE,
                            arguments: _bloc);
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(243, 241, 237, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: listaPets![index].imagem != null
                                  ? Image.memory(
                                      listaPets[index].imagem!,
                                      height: 140,
                                      width: 175,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 4),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "${listaPets[index].nome}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Divider(),
                            _retornaDescricaoPetGridview(
                                Icons.eighteen_mp_outlined,
                                "${listaPets[index].idade}"),
                            _retornaDescricaoPetGridview(Icons.pets_outlined,
                                "${listaPets[index].raca}"),
                            _retornaDescricaoPetGridview(
                                Icons.fmd_good_outlined,
                                "${listaPets[index].localizacao}"),
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget _retornaDescricaoPetGridview(IconData icon, String descricao) {
    return new Container(
        padding: EdgeInsets.only(left: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color.fromRGBO(96, 80, 136, 1),
              size: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                descricao,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  Widget _buildBarraPesquisa() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Text('O que está buscando?'),
          ),
          Container(
              padding: EdgeInsets.only(right: 16), child: Icon(Icons.search)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: const Color.fromRGBO(96, 80, 136, 1),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      backgroundColor: Colors.white,
      title: new Text(
        'OLX DE DOGUINHO',
        style: new TextStyle(
          color: const Color.fromRGBO(96, 80, 136, 1),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () {
           
          },
          child: new Container(
            padding: const EdgeInsets.only(right: 16),
            child: new Icon(
              Icons.inbox,
              color: const Color.fromRGBO(96, 80, 136, 1),
            ),
          ),
        )
      ],
    );
  }

  _buildDrawer() {
    return Drawer(
      backgroundColor: Color.fromRGBO(96, 80, 136, 1),
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  new Image.asset(
                    "assets/logo.png",
                    scale: 1.8,
                  ),
                  new  Text(
                    'OLX DE DOGUINHO',
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Color.fromRGBO(243, 241, 237, 1)),
          ListTile(
            leading: Icon(
              Icons.pets_outlined,
              color: Colors.white,
            ),
            title: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(CadastroPet.ROUTE, arguments: _bloc!);
              },
              child: Text(
                "Cadastre seu PET",
                style: TextStyle(color: Color.fromRGBO(243, 241, 237, 1)),
              ),
            ),
            style: ListTileStyle.drawer,
          ),
          Divider(color: Color.fromRGBO(243, 241, 237, 1)),
          ListTile(
            leading: Icon(
              Icons.info_outlined,
              color: Colors.white,
            ),
            title: GestureDetector(
              child: Text("Sobre Nós",
                  style: TextStyle(color: Color.fromRGBO(243, 241, 237, 1))),
            ),
            style: ListTileStyle.drawer,
          ),
          Divider(color: Color.fromRGBO(243, 241, 237, 1)),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: GestureDetector(
              child: Text("Configurações",
                  style: TextStyle(color: Color.fromRGBO(243, 241, 237, 1))),
            ),
            style: ListTileStyle.drawer,
          ),
        ],
      ),
    );
  }
}
