import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/pedidoItem.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_completed_screen.dart';
import 'package:vendasagrindus/screens/pedidos/edit_order_screen.dart';
import 'package:vendasagrindus/screens/pedidos/order_widgets.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../data_helper.dart';
import 'package:http/http.dart' as http;

class OrderSummaryScreen extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final double pesoTotal;
  final Cliente cliente;
  final bool isSaved;
  final String obsText;
  final int currentOrder;
  final DateTime orderDate;
  OrderSummaryScreen(
    this.items,
    this.total,
    this.pesoTotal,
    this.cliente, {
    this.isSaved = false,
    this.obsText,
    this.currentOrder,
    this.orderDate,
  });

  @override
  _OrderSummaryScreenState createState() =>
      _OrderSummaryScreenState(items, date: orderDate);
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  _OrderSummaryScreenState(this.currentItems, {this.date});

  List<CartItem> currentItems = List<CartItem>();
  DateTime date;
  TextEditingController obsController = TextEditingController();
  TextEditingController clientNumberController = TextEditingController();
  bool showSpinner = false;
  List<PedidoItem> _toPedidoItem(String numeroSFA, DateTime date) {
    List<PedidoItem> aux = [];
    int sequencia = 1;
    for (var item in currentItems) {
      aux.add(
        PedidoItem(
          sEQUENCIA: sequencia.toString(),
          cPRODPALM: item.code,
          qTDE: item.amount,
          vLRUNIT: item.price,
          vLRTOTAL: item.total,
          dTENTREGA: DateFormat('yyyyMMdd').format(date),
          nROLISTA: widget.cliente.pRIORIDADE.toString(),
          dESCRICAO: item.name,
          cODBARRA: item.barCode,
          iMAGE: item.image,
          pESO: item.weight,
          gRUPO: '',
          tES: widget.cliente.tIPOMOVIMENTO.tIPOMOVTO,
          uNIDADE: item.unity,
          rESERVADO2: 0,
          rESERVADO5: 0,
          rESERVADO8: 0,
          rESERVADO13: '',
          rESERVADO14: '',
          rESERVADO15: '',
          rESERVADO16: '',
        ),
      );
      sequencia++;
    }
    return aux;
  }

  double currentTotal() {
    double sum = 0.0;
    for (var item in currentItems) {
      sum += item.total;
    }
    return sum;
  }

  double currentWieght() {
    double sum = 0.0;
    for (var item in currentItems) {
      sum += item.pesoTotal;
    }
    return sum;
  }

  @override
  void initState() {
    super.initState();
    if (date == null) {
      date = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        if (widget.obsText != null) {
          obsController.text = widget.obsText;
        }
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Resumo do pedido'),
              actions: widget.isSaved
                  ? [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () async {
                          List newItens = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditOrderScreen(
                                    widget.cliente, currentItems)),
                          );
                          setState(() {
                            currentItems = newItens;
                          });
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            Alert(
                              context: context,
                              title: 'DELETAR PEDIDO',
                              desc:
                                  'Deseja deletar este pedido? A ação não poderá ser desfeita.',
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
                                    onTap: () {
                                      userdata.removeOrder(widget.currentOrder);
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    }),
                              ],
                            ).show();
                          }),
                    ]
                  : null,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 8),
                        ListView.builder(
                          itemCount: currentItems.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return FinalItem(
                              item: currentItems[index],
                              deleteFunction: () {
                                if (currentItems.length <= 1) {
                                  Alert(
                                    context: context,
                                    title: 'ÚLTIMO ITEM DO PEDIDO',
                                    desc:
                                        'Ao remover este item, estará cancelando o pedido. Deseja prosseguir?',
                                    style: kAlertCardStyle,
                                    buttons: [
                                      AlertButton(
                                          label: 'Não',
                                          line: Border.all(
                                              color: Colors.grey[600]),
                                          labelColor: Colors.grey[600],
                                          hasGradient: false,
                                          cor: Colors.white,
                                          onTap: () {
                                            Navigator.pop(context);
                                          }),
                                      AlertButton(
                                          label: 'Sim',
                                          onTap: () {
                                            if (widget.isSaved) {
                                              userdata.removeOrder(
                                                  widget.currentOrder);
                                            } else {
                                              currentItems.removeAt(index);
                                            }

                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          }),
                                    ],
                                  ).show();
                                } else {
                                  Alert(
                                    context: context,
                                    title: 'REMOVER ITEM',
                                    desc:
                                        'Deseja remover este item do carrinho?',
                                    style: kAlertCardStyle,
                                    buttons: [
                                      AlertButton(
                                          label: 'Não',
                                          line: Border.all(
                                              color: Colors.grey[600]),
                                          labelColor: Colors.grey[600],
                                          hasGradient: false,
                                          cor: Colors.white,
                                          onTap: () {
                                            Navigator.pop(context);
                                          }),
                                      AlertButton(
                                          label: 'Sim',
                                          onTap: () {
                                            setState(() {
                                              currentItems.removeAt(index);
                                            });
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  ).show();
                                }
                              },
                            );
                          },
                        ),
                        SummaryHeader(
                            headerText: 'Data da entrega',
                            padding: EdgeInsets.all(15)),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: FlatButton(
                            onPressed: () async {
                              final aux = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(date.year + 3));
                              if (aux != null) {
                                setState(() {
                                  date = aux;
                                });
                              }
                            },
                            child: Text(DateFormat('dd/MM/yyyy').format(date)),
                            color: Colors.grey[200],
                          ),
                        ),
                        SummaryHeader(
                            headerText: 'Resumo do pedido',
                            padding: EdgeInsets.only(left: 15, top: 10)),
                        DetailsCard(
                          items: [
                            DetailItem(
                              title: 'Condição do pagamento:',
                              description:
                                  '${widget.cliente.cONDPAGTO} - ${widget.cliente.cONDPAGTOobj.dESCRICAO}',
                              colour: Colors.blueGrey[700],
                            ),
                            DetailItem(
                              title: 'Tipo de movimento:',
                              description:
                                  '${widget.cliente.tIPOMOVIMENTO.tIPOMOVTO} - ${widget.cliente.tIPOMOVIMENTO.dESCRICAO}',
                              colour: Colors.blueGrey[700],
                            ),
                            DetailItem(
                              title: 'Peso total:',
                              description:
                                  '${DataHelper.brNumber.format(currentWieght())} kg',
                              colour: Colors.blueGrey[700],
                            ),
                            DetailItem(
                              title: 'Total:',
                              description:
                                  'R\$ ${DataHelper.brNumber.format(currentTotal())}',
                              colour: Colors.blueGrey[700],
                            ),
                          ],
                        ),
                        SummaryHeader(
                            headerText: 'Observações finais',
                            padding: EdgeInsets.only(left: 15, top: 10)),
                        NotesBox(
                            controller: obsController,
                            hintText: 'Observações finais do pedido...'),
                        SummaryHeader(
                            headerText: 'Número do pedido do cliente',
                            padding: EdgeInsets.only(left: 15, top: 10)),
                        NotesBox(
                          controller: clientNumberController,
                          maxLines: 1,
                          inputType: TextInputType.number,
                          hintText: '(Opcional)',
                        ),
                      ],
                    ),
                  ),
                ),
                TotalSummary(value: DataHelper.brNumber.format(currentTotal())),
                SummaryButton(
                  saveFunction: () {
                    var newOrder = PedidoMestre(
                      nUMEROSFA: userdata.vendedor.pROXIMOPED,
                      cLIENTE: widget.cliente.cLIENTE,
                      cONDPAGTO: widget.cliente.cONDPAGTO,
                      vENDEDOR: userdata.vendedor.vENDEDOR,
                      dTPED: DateFormat('yyyyMMdd').format(DateTime.now()),
                      nROLISTA: widget.cliente.pRIORIDADE.toString(),
                      tIPOCLI: widget.cliente.tIPOCLI,
                      vLRPED: DataHelper.brNumber.format(currentTotal()),
                      nOMECLIENTE: widget.cliente.nOMFANTASIA,
                      tEXTOESP: obsController.text,
                      pESOTOTAL: currentWieght(),
                      rESERVADO2: 0,
                      rESERVADO8: 0,
                      iTENSDOPEDIDO:
                          _toPedidoItem(userdata.vendedor.pROXIMOPED, date),
                    );
                    userdata.saveOrder(newOrder);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  sendFunction: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    final String urlMestre = baseUrl + 'PedidoMestre';
                    final String urlItens = baseUrl + 'PedidoItens';
                    try {
                      var bodyMestre = jsonEncode(
                        [
                          {
                            'MBPM': [
                              {
                                'NUMERO_SFA': userdata.vendedor.pROXIMOPED,
                                'CLIENTE': widget.cliente.cLIENTE,
                                'COND_PAGTO': widget.cliente.cONDPAGTO,
                                'VENDEDOR': userdata.vendedor.vENDEDOR,
                                'TEXTO_ESP':
                                    obsController.text, //não pode ser vazio
                                'DT_PED': DateFormat('yyyyMMdd')
                                    .format(DateTime.now()),
                                'NRO_LISTA':
                                    widget.cliente.pRIORIDADE.toString(),
                                'TIPO_CLI': widget.cliente.tIPOCLI,
                                'RESERVADO2': 0,
                                'RESERVADO8': 0,
                              }
                            ],
                          },
                        ],
                      );
                      List<dynamic> formattedItens = [];

                      for (var item in _toPedidoItem(
                          userdata.vendedor.pROXIMOPED, date)) {
                        formattedItens.add({
                          'NUMERO_SFA': userdata.vendedor.pROXIMOPED,
                          'SEQUENCIA': item.sEQUENCIA,
                          'C_PROD_PALM': item.cPRODPALM,
                          'QTDE': item.qTDE,
                          'VLR_UNIT': item.vLRUNIT,
                          'VLR_TOTAL': item.vLRTOTAL,
                          'DT_ENTREGA': item.dTENTREGA,
                          'UNIDADE': item.uNIDADE,
                          'TES': widget.cliente.tIPOMOVIMENTO.tIPOMOVTO,
                          'GRUPO': '',
                          'NRO_LISTA': item.nROLISTA,
                          'RESERVADO2': 0,
                          'RESERVADO5': 0,
                          'RESERVADO8': 0,
                          'RESERVADO13': '',
                          'RESERVADO14': '',
                          'RESERVADO15': '',
                          'RESERVADO16': '',
                        });
                      }
                      var bodyItens = jsonEncode(
                        [
                          {
                            'MBPD': formattedItens,
                          },
                        ],
                      );
                      final responseMestre = await http.post(
                        urlMestre,
                        headers: {'Content-Type': 'application/json'},
                        body: bodyMestre,
                      );
                      final responseItens = await http.post(
                        urlItens,
                        headers: {'Content-Type': 'application/json'},
                        body: bodyItens,
                      );
                      setState(() {
                        showSpinner = false;
                      });
                      if (responseItens.statusCode == 201 &&
                          responseItens.statusCode == 201) {
                        print(responseItens.statusCode);
                        print('Post sucessful!');
                        if (widget.isSaved) {
                          await userdata.removeOrder(widget.currentOrder);
                        }
                        await userdata.updateVendedor();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderCompletedScreen()));
                      } else {
                        Alert(
                          context: context,
                          title: 'ERRO',
                          desc:
                              'Houve um problema ao enviar seu pedido. (Erro ${responseItens.statusCode})',
                          style: kAlertCardStyle,
                          buttons: [
                            AlertButton(
                                label: 'VOLTAR',
                                onTap: () {
                                  Navigator.pop(context);
                                })
                          ],
                        ).show();
                        print(responseMestre.statusCode);
                        print(responseItens.statusCode);
                        print('Post failed...');
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
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
                      print(e);
                      print('Post failed...');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
