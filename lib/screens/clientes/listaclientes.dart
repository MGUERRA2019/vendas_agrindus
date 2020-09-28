import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:vendasagrindus/model/clientes.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../api.dart';

class ListaClientes extends StatefulWidget {
  @override
  _ListaClientesState createState() => _ListaClientesState();
}

class _ListaClientesState extends State<ListaClientes> {
  var clientes = List<Clientes>();

  _getClientes() {
    API.getClientes().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        clientes = lista.map((model) => Clientes.fromJson(model)).toList();
      });
    });
  }

  _ListaClientesState() {
    _getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Lista de Clientes'),
        ),
        body: listaClientes());
  }

  listaClientes() {
    return ListView.builder(
      itemCount: clientes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blue[100],
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(
              clientes[index].nOMFANTASIA,
              style: TextStyle(fontSize: 16, color: kTextColor,),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: <Widget>[
                Text(
                  clientes[index].eNDERECO,
                  style: TextStyle(fontSize: 14),
                ),
                Row(children: <Widget>[
                  Text(
                    clientes[index].bAIRRO + ' - ',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    clientes[index].cIDADE,
                    style: TextStyle(fontSize: 10),
                  ),
                ]),
              ],
            ),
            trailing: Icon(Icons.credit_card),
          ),
        );
      },
    );
  }
}
