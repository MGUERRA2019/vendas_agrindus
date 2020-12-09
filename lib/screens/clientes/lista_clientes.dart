import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/screens/clientes/client_details_screen.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class ListaClientes extends StatefulWidget {
  static const String routeName = 'lista_clientes';

  @override
  _ListaClientesState createState() => _ListaClientesState();
}

class _ListaClientesState extends State<ListaClientes> {
  Iterable<Cliente> _clientQuery(UserData userdata, String search) {
    Iterable<Cliente> query = [];

    query = userdata.clientes;

    if (search != null || search != '') {
      query = query.where((element) => element.nOMFANTASIA.contains(search));
    }

    return query;
  }

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Clientes'),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final String result = await showSearch(
                      context: context,
                      delegate: ClientsSearch(
                          Provider.of<UserData>(context, listen: false)
                              .clientes));
                  setState(() {
                    query = result;
                  });
                })
          ],
        ),
        backgroundColor: kBackgroundColor,
        // bottomNavigationBar: ,
        body: Consumer<UserData>(
          builder: (context, userdata, child) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _clientQuery(userdata, query).length,
              itemBuilder: (context, index) {
                Cliente cliente =
                    _clientQuery(userdata, query).elementAt(index);
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: OpenContainer(
                      closedElevation: 2.5,
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      closedColor: Colors.white,
                      transitionDuration: Duration(milliseconds: 500),
                      openBuilder: (context, closeWidget) {
                        return ClientDetailsScreen(cliente);
                      },
                      closedBuilder: (context, openWidget) {
                        return Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.account_circle),
                              backgroundColor: Color(0X42046dc8),
                              foregroundColor: Color(0XB3046dc8),
                            ),
                            title: Text(
                              cliente.nOMFANTASIA,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  cliente.eNDERECO,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                Row(children: <Widget>[
                                  Text(
                                    cliente.bAIRRO + ' - ',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                    cliente.cIDADE,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
            );
          },
        ));
  }
}

class ClientsSearch extends SearchDelegate<String> {
  final List<Cliente> clientes;

  ClientsSearch(this.clientes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = clientes.where((element) =>
        element.nOMFANTASIA.toLowerCase().contains(query.toLowerCase()));
    return ListView(
      children: results
          .map<ListTile>((e) => ListTile(
                title: Text(e.nOMFANTASIA),
                onTap: () {
                  close(context, e.nOMFANTASIA);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = clientes.where((element) =>
        element.nOMFANTASIA.toLowerCase().contains(query.toLowerCase()));
    return ListView(
      children: results
          .map<ListTile>((e) => ListTile(
                title: Text(e.nOMFANTASIA),
                onTap: () {
                  close(context, e.nOMFANTASIA);
                },
              ))
          .toList(),
    );
  }
}
