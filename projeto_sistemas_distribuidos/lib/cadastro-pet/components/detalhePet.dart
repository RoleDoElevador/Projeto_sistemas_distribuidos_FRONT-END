import 'package:flutter/material.dart';
import 'package:projeto_sistemas_distribuidos/cadastro-pet/bloc/cadastro-pet-cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 4,
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.chevron_left,
                            color: Theme.of(context).primaryColor, size: 50),
                        onPressed: () => {},
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Container(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, int i) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Container(
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.only(left: 4, right: 4),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                                    ))
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height,
                      width: 50,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.chevron_right,
                            color: Theme.of(context).primaryColor, size: 50),
                        onPressed: () => {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
