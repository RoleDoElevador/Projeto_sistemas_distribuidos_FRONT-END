import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetalhePet extends StatefulWidget {
  const DetalhePet({Key? key}) : super(key: key);

  @override
  State<DetalhePet> createState() => _DetalhePetState();
}

class _DetalhePetState extends State<DetalhePet> {
  CadastroPetCubit? _bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _bloc = new CadastroPetCubit();
        print(_bloc?.teste);
        return _bloc!;
      },
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.grey,
            ),
            title: Text(
              '${_bloc?.teste}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
        ),
      ),
    );
  }
}
