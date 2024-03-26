import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/pedidoMestreFull.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_list/order_list_bloc.dart';
import 'package:vendasagrindus/screens/profile_drawer.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/styles.dart';

class OrderListScreen extends StatefulWidget {
  //Tela que mostra os pedidos realizados pelo vendedor
  //Dados controlados pelo order_list_bloc.dart
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  int numberOfOrders = 0;
  List<PedidoMestreFull> ordersList = [];
  int currentMax = 9;
  ScrollController _scrollController = ScrollController();
  OrderListBloc _bloc;
  DateTime selectedDate;
  bool queryOn = false;

  @override
  void initState() {
    super.initState();
    UserData userData = Provider.of<UserData>(context, listen: false);
    _bloc = OrderListBloc(userData.vendedor.vENDEDOR, userData.baseUrl);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !queryOn) {
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
      appBar: AppBar(
        title: Text('Lista de pedidos'),
        elevation: 0,
      ),
      drawer: ProfileDrawer(),
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.date_range,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              FlatButton(
                child: Text(selectedDate == null
                    ? 'Selecionar data'
                    : DateFormat('dd/MM/yyyy').format(selectedDate)),
                color: kBackgroundColor2,
                onPressed: () async {
                  selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime.now());
                  if (selectedDate != null) {
                    _bloc.queryDatabyDate(selectedDate);
                    setState(() {
                      queryOn = true;
                    });
                  }
                },
              ),
              Visibility(
                visible: queryOn,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Color(0xAFFFFFFF),
                    ),
                    onPressed: () {
                      _bloc.cancelQuery();
                      setState(() {
                        selectedDate = null;
                        queryOn = false;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: StreamBuilder(
                stream: _bloc.output,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data.length < 1) {
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 270,
                        height: 270,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                ExactAssetImage('assets/images/not_found.png'),
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length + 1,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index < snapshot.data.length) {
                          Cliente cliente = Provider.of<UserData>(context,
                                  listen: false)
                              .getClienteFromCod(snapshot.data[index].cLIENTE);
                          String nomeCliente = '';
                          if (cliente != null) {
                            nomeCliente = cliente.nOMFANTASIA;
                          }
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
                                  title: 'Cliente:', description: nomeCliente),
                              DetailItem(
                                  title: 'Preço total:',
                                  description:
                                      'R\$ ${snapshot.data[index].vLRPED}'),
                              DetailItem(
                                  title: 'Carga total:',
                                  description:
                                      '${snapshot.data[index].cARGATOTAL} kg'),
                            ],
                          );
                        } else if (_bloc.hasMore) {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(),
                          ));
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
