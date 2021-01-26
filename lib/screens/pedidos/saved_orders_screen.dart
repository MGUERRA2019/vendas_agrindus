import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_completed_screen.dart';
import 'package:vendasagrindus/screens/pedidos/order_summary_screen.dart';
import 'package:vendasagrindus/screens/profile_drawer.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';

import '../../data_helper.dart';

class SavedOrdersScreen extends StatefulWidget {
  @override
  _SavedOrdersScreenState createState() => _SavedOrdersScreenState();
}

class _SavedOrdersScreenState extends State<SavedOrdersScreen> {
  bool showSpinner = false;

  List<CartItem> _toCartItem(List<dynamic> itensDoPedido) {
    List<CartItem> aux = [];
    for (var item in itensDoPedido) {
      if (item is Map) {
        aux.add(CartItem(
          name: item['DESCRICAO'],
          amount: item['QTDE'],
          price: item['VLR_UNIT'],
          barCode: item['COD_BARRA'],
          code: item['C_PROD_PALM'],
          image: item['IMAGE'],
          weight: item['PESO'],
          unity: item['UNIDADE'],
          group: item['GRUPO'],
        ));
      }
    }
    return aux;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserData>(context, listen: false).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Pedidos Salvos'),
              actions: [
                IconButton(
                    icon: Icon(Icons.file_upload),
                    onPressed: () {
                      Alert(
                        context: context,
                        title: 'ENVIAR PEDIDOS',
                        desc: 'Deseja enviar todos os pedidos salvos?',
                        style: kAlertCardStyle,
                        buttons: [
                          AlertButton(
                              label: 'Não',
                              line: Border.all(color: Colors.grey[600]),
                              labelColor: Colors.grey[600],
                              hasGradient: false,
                              cor: Colors.white,
                              onTap: () {
                                Navigator.pop(context);
                              }),
                          AlertButton(
                              label: 'Sim',
                              onTap: () async {
                                Navigator.pop(context);
                                try {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  await userdata.sendAllOrders();
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderCompletedScreen()));
                                } catch (e) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  print('Post failed at the process');
                                  print(e);
                                  Alert(
                                    context: context,
                                    title: 'ERRO',
                                    desc: e.toString(),
                                    style: kAlertCardStyle,
                                    buttons: [
                                      AlertButton(
                                          label: 'VOLTAR',
                                          onTap: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  ).show();
                                }
                              }),
                        ],
                      ).show();
                    })
              ],
            ),
            drawer: ProfileDrawer(),
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
                                  .pedidosSalvos[index]['ITENS_DO_PEDIDO']
                                  .length
                                  .toString())
                        ],
                        isInteractive: true,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderSummaryScreen(
                                        _toCartItem(
                                            userdata.pedidosSalvos[index]
                                                ['ITENS_DO_PEDIDO']),
                                        DataHelper.brNumber.parse(userdata
                                            .pedidosSalvos[index]['VLR_PED']),
                                        DataHelper.brNumber.parse(
                                            userdata.pedidosSalvos[index]
                                                ['CARGA_TOTAL']),
                                        userdata
                                            .getClienteFromPedidosSalvos(index),
                                        isSaved: true,
                                        currentOrder: index,
                                        orderDate: DateTime.parse(userdata
                                            .pedidosSalvos[index]['DT_PED']),
                                        obsText: userdata.pedidosSalvos[index]
                                            ['TEXTO_ESP'],
                                        clientOrderNumber:
                                            userdata.pedidosSalvos[index]
                                                ['RESERVADO13'],
                                      ))).then((value) {
                            userdata.getOrders();
                          });
                        },
                      );
                    },
                  )
                : Center(
                    child: Container(
                      width: 270,
                      height: 270,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/not_found.png'),
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
