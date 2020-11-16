import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_summary_screen.dart';
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

  List<CartItem> _toCartItem(List<dynamic> itensDoPedido) {
    List<CartItem> aux = [];
    for (var item in itensDoPedido) {
      if (item is Map) {
        aux.add(CartItem(
          name: item['DESCRICAO'],
          amount: int.parse(item['QTDE']),
          price: DataHelper.brNumber.parse(item['VLR_UNIT']),
          barCode: item['COD_BARRA'],
          code: item['C_PROD_PALM'],
          image: item['IMAGE'],
          weight: item['PESO'],
        ));
      }
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
          body: userdata.pedidosSalvos.length > 0
              ? ListView.builder(
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
                                builder: (context) => OrderSummaryScreen(
                                      _toCartItem(userdata.pedidosSalvos[index]
                                          ['ITENS_DO_PEDIDO']),
                                      DataHelper.brNumber.parse(userdata
                                          .pedidosSalvos[index]['VLR_PED']),
                                      userdata.pedidosSalvos[index]
                                          ['PESO_TOTAL'],
                                      userdata
                                          .getClienteFromPedidosSalvos(index),
                                      isSaved: true,
                                      currentOrder: index,
                                    )));
                      },
                    );
                  },
                )
              : Center(
                  child: SvgPicture.asset(
                    'assets/images/not_found.svg',
                    height: 270,
                    width: 270,
                  ),
                ),
        );
      },
    );
  }
}
