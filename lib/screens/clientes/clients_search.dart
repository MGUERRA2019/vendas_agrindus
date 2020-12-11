import 'package:flutter/material.dart';
import 'package:vendasagrindus/model/cliente.dart';

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
  Widget buildResults(BuildContext context) => null;

  @override
  void showResults(BuildContext context) {
    close(context, query.toUpperCase());
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
