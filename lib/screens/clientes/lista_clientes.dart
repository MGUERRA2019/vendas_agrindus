import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/screens/details/client_details_screen.dart';
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
        backgroundColor: Color(0xFFF4F5F9), //Color(0xFFEEF0F4),
        // bottomNavigationBar: ,
        body: Consumer<UserData>(
          builder: (context, userdata, child) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: userdata.clientes.length,
              itemBuilder: (context, index) {
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
                        return ClientDetailsScreen();
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
                              userdata.clientes[index].nOMFANTASIA,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
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
