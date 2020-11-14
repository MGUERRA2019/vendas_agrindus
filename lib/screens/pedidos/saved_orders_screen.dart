import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/pedidoItem.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_confirm.dart';
import 'package:vendasagrindus/user_data.dart';

import '../../data_helper.dart';

class SavedOrdersScreen extends StatefulWidget {
  @override
  _SavedOrdersScreenState createState() => _SavedOrdersScreenState();
}

class _SavedOrdersScreenState extends State<SavedOrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserData>(context, listen: false).getOrders();
  }

  List<CartItem> _toCartItem(List<PedidoItem> itensDoPedido) {
    List<CartItem> aux = [];
    for (var item in itensDoPedido) {
      aux.add(CartItem(
        name: item.dESCRICAO,
        amount: int.parse(item.qTDE),
        price: DataHelper.brNumber.parse(item.vLRUNIT),
      ));
    }

    return aux;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Pedidos Salvos'),
          ),
          body: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: userdata.pedidosSalvos.length,
            itemBuilder: (context, index) {
              return DetailsCard(
                items: [
                  DetailItem(
                      title: 'Cliente: ',
                      description: userdata.pedidosSalvos[index]
                          ['NOME_CLIENTE']),
                  DetailItem(
                      title: 'Total:',
                      description:
                          'R\$ ${userdata.pedidosSalvos[index]['VLR_PED']}'),
                  DetailItem(
                      title: 'Número de itens:',
                      description: userdata
                          .pedidosSalvos[index]['ITENS_DO_PEDIDO'].length
                          .toString())
                ],
                isInteractive: true,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderConfirm(
                                _toCartItem(userdata.pedidosSalvos[index]
                                    ['ITENS_DO_PEDIDO']),
                                DataHelper.brNumber.parse(
                                    userdata.pedidosSalvos[index]['VLR_TOTAL']),
                                userdata.pedidosSalvos[index]['PESO_TOTAL'],
                                userdata.getClienteFromPedidosSalvos(index),
                                isSaved: true,
                              )));
                },
              );
            },
          ),
        );
      },
    );
  }
}
