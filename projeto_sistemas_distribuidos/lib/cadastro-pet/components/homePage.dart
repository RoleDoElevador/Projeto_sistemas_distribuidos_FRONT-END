import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit-model.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
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
            backgroundColor: Color.fromRGBO(243, 241, 237, 1),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: _buildAppBar(),
            ),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
      backgroundColor: const Color.fromRGBO(243, 241, 237, 1),
      leading: new Drawer(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(243, 241, 237, 1),
        child: new Icon(
          Icons.add,
          color: const Color.fromRGBO(96, 80, 136, 1),
        ),
      ),
      title: new Text(
        'OLX DE DOGUINHO',
        style: new TextStyle(
          color: const Color.fromRGBO(96, 80, 136, 1),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        new Container(
          padding: const EdgeInsets.only(right: 16),
          child: new Icon(
            Icons.inbox,
            color: const Color.fromRGBO(96, 80, 136, 1),
          ),
        )
      ],
    );
  }

  _buildBody() {
    return Center(
      child: FloatingActionButton(
        child: Text('OI'),
        onPressed: () {
          Navigator.of(context).pushNamed(DetalhePet.ROUTE, arguments:  _bloc);
        },
      ),
    );
  }
}
