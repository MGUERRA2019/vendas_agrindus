import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:vendasagrindus/model/clientes.dart';
import 'package:vendasagrindus/model/vendedor.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../data_helper.dart';

class ListaClientes extends StatefulWidget {
  static const String routeName = 'lista_clientes';

  @override
  _ListaClientesState createState() => _ListaClientesState();
}

class _ListaClientesState extends State<ListaClientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Clientes'),
        ),
        // bottomNavigationBar: ,
        body: Consumer<UserData>(
          builder: (context, userdata, child) {
            return ListView.builder(
              itemCount: userdata.clientes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue[100],
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.account_circle),
                      backgroundColor: Colors.black26,
                      foregroundColor: Colors.white70,
                    ),
                    title: Text(
                      userdata.clientes[index].nOMFANTASIA,
                      style: TextStyle(
                        fontSize: 16,
                        color: kTextColor,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userdata.clientes[index].eNDERECO,
                          style: TextStyle(fontSize: 14),
                        ),
                        Row(children: <Widget>[
                          Text(
                            userdata.clientes[index].bAIRRO + ' - ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            userdata.clientes[index].cIDADE,
                            style: TextStyle(fontSize: 10),
                          ),
                        ]),
                        Text(
                          'Vendedor: ' + userdata.clientes[index].vENDEDOR,
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.credit_card),
                  ),
                );
              },
            );
          },
        ));
  }
}
