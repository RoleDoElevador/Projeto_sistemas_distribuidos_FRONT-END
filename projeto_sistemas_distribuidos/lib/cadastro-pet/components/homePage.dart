import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit-model.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/cadastro-pet-form.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/components/detalhePet.dart';

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

        return _bloc!;
      },
      child: new BlocBuilder<CadastroPetCubit, CadastroPetModel>(
        builder: (context, state) {
          return new Scaffold(
            drawer: Drawer(
              backgroundColor: Color.fromRGBO(96, 80, 136, 1),
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: _buildAppBar(),
            ),
            extendBodyBehindAppBar: false,
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
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
          onTap: () {},
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

  _buildBody() {
    return Column(
      children: [
        _buildBarraPesquisa(),
        new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.299,
          padding: EdgeInsets.only(top: 20),
          child: BlocBuilder<CadastroPetCubit, CadastroPetModel>(
            builder: (context, state) {
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      mainAxisExtent: 260),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                         Navigator.pushNamed(context, DetalhePet.ROUTE, arguments: _bloc);
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
                              child: Image.asset(
                                "assets/cachorro.jpg",
                                height: 140,
                                width: 175,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 4),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Thanos",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Divider(),
                            _retornaDescricaoPetGridview(
                                Icons.eighteen_mp_outlined, "4 anos"),
                            _retornaDescricaoPetGridview(
                                Icons.pets_outlined, 'Vira-lata'),
                            _retornaDescricaoPetGridview(
                                Icons.fmd_good_outlined, "São Paulo/SP"),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: Color.fromRGBO(96, 80, 136, 1),
            onPressed: () {
              Navigator.of(context).pushNamed(CadastroPet.ROUTE, arguments: _bloc);
            },
            child: Icon(Icons.add),
            elevation: 1,
          ),
        ),
      ],
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
}
