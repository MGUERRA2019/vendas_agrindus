import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:darq/darq.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String currentClient;
  List<String> clients = [];

  String getCliente(String name, List<Cliente> clientes) {
    return clientes
        .firstWhere((element) => (element.nOMFANTASIA == name))
        .cLIENTE;
  }

  @override
  void initState() {
    super.initState();
    UserData userdata = Provider.of<UserData>(context, listen: false);
    clients = userdata.clientes
        .select((element, index) => element.nOMFANTASIA)
        .toList();

    currentClient = clients.first;
    userdata.getPedidoMestre(userdata.clientes.first.cLIENTE);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userdata, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Histórico de Pedidos'),
        ),
        body: Column(
          children: [
            DropdownButton<String>(
                value: currentClient,
                items: _getDropdownItems(clients),
                onChanged: (value) {
                  setState(() {
                    currentClient = value;
                    userdata.getPedidoMestre(
                        getCliente(currentClient, userdata.clientes));
                  });
                }),
            Expanded(
              child: ListView.builder(
                itemCount: userdata.pedidosMestre.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.all(20),
                      height: 50,
                      width: 50,
                      color: Colors.orange,
                      child: Center(
                          child:
                              Text(userdata.pedidosMestre[index].nUMEROSFA)));
                },
              ),
            )
          ],
        ),
      );
    });
  }
}

List<DropdownMenuItem> _getDropdownItems(List<String> clientes) {
  List<DropdownMenuItem<String>> list = [];
  for (var item in clientes) {
    var newItem = DropdownMenuItem(
      child: Text(item.toString()),
      value: item,
    );
    list.add(newItem);
  }
  return list;
}
