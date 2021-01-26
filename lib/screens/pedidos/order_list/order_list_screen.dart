import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/model/pedidoMestreFull.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_list/order_list_bloc.dart';
import 'package:vendasagrindus/screens/profile_drawer.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  int numberOfOrders = 0;
  List<PedidoMestreFull> ordersList = [];
  int currentMax = 9;
  ScrollController _scrollController = ScrollController();
  OrderListBloc _bloc;

  _firstData() {
    Provider.of<UserData>(context, listen: false).getPedidoMestreFull();
    for (var item in Provider.of<UserData>(context, listen: false)
        .allData
        .getRange(0, 9)) {
      setState(() {
        ordersList.add(item);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = OrderListBloc(
        Provider.of<UserData>(context, listen: false).vendedor.vENDEDOR);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _bloc.addMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de pedidos')),
      drawer: ProfileDrawer(),
      body: StreamBuilder(
        stream: _bloc.output,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return DetailsCard(
                    items: [
                      Row(
                        children: [
                          Text(
                            'Pedido ${snapshot.data[index].nUMEROSFA}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.blueGrey[700]),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      DetailItem(
                          title: 'Data:',
                          description: DateFormat('dd/MM/yyyy')
                              .format(snapshot.data[index].dTPED)),
                      DetailItem(
                          title: 'Cliente:',
                          description: Provider.of<UserData>(context,
                                  listen: false)
                              .getClienteFromCod(snapshot.data[index].cLIENTE)
                              .nOMFANTASIA),
                      DetailItem(
                          title: 'Pedido total:',
                          description: snapshot.data[index].vLRPED),
                      DetailItem(
                          title: 'Peso total:',
                          description: snapshot.data[index].cARGATOTAL),
                    ],
                  );
                } else {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ));
                }
              },
            );
          }
        },
      ),
    );
  }
}
