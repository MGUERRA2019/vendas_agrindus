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

//Tela que mostra o resumo do pedido
//Tela importante que pode ser acessada tanto após um novo pedido ser efetuado (new_order_screen.dart) como por um pedido salvo (saved_orders_screen.dart)
//Tela também que efetua o envio do pedido ou a gravação do pedido (saved_orders_screen.dart)

class OrderSummaryScreen extends StatefulWidget {
  final List<CartItem> items;

  final Cliente cliente;
  final bool isSaved;
  final String obsText;
  final String clientOrderNumber;
  final int currentOrder;
  final DateTime orderDate;
  OrderSummaryScreen(
    this.items,
    this.cliente, {
    this.isSaved = false,
    this.obsText,
    this.clientOrderNumber,
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
  TextEditingController obsController;
  TextEditingController clientNumberController;
  bool showSpinner = false;
  List<PedidoItem> _toPedidoItem(String numeroSFA, DateTime date) {
    //Conversão dos itens do carrinho para o tipo Pedido Item (MBPD)
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
          gRUPO: '', //não utilizável
          tES: widget.cliente.tIPOMOVIMENTO.tIPOMOVTO,
          uNIDADE: item.unity,
          rESERVADO2: 0, //não incube ao app
          rESERVADO5: 0, //não incube ao app
          rESERVADO13:
              clientNumberController.text, //Número de pedido do cliente
          rESERVADO14: DateFormat('yyyyMMdd')
              .format(DateTime.now()), //data do dia do pedido
          rESERVADO15: '', //não incube ao app
          rESERVADO16: widget.cliente.cLIENTE, //Código do cliente
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

  double currentWeight() {
    double sum = 0.0;
    for (var item in currentItems) {
      sum += item.pesoTotal;
    }
    return sum;
  }

  Future<DateTime> _regrasTipoMovimento() async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (widget.cliente.tIPOMOVIMENTO.tIPOMOVTO == '310' ||
        widget.cliente.tIPOMOVIMENTO.tIPOMOVTO == '480') {
      if (today.difference(date) > Duration(days: 1)) {
        setState(() {
          date = today;
        });
      }
      return showDatePicker(
          context: context,
          initialDate: (date.isBefore(today) || date.isAtSameMomentAs(today))
              ? today.add(Duration(days: 1))
              : date,
          firstDate: now.add(Duration(days: 1)),
          lastDate: now.add(Duration(days: 31)));
    } else if (widget.cliente.tIPOMOVIMENTO.tIPOMOVTO == '315') {
      if (today.difference(date) > Duration(days: 35)) {
        setState(() {
          date = today;
        });
      }
      return showDatePicker(
          context: context,
          initialDate: date,
          firstDate: now.subtract(Duration(days: 35)),
          lastDate: now);
    } else {
      return showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime.now().subtract(Duration(days: 500)),
          lastDate: DateTime(date.year + 3));
    }
  }

  @override
  void initState() {
    super.initState();
    if (date == null) {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      if (widget.cliente.tIPOMOVIMENTO.tIPOMOVTO == '315') {
        date = today;
      } else {
        date = today.add(Duration(days: 1));
      }
    }
    obsController = TextEditingController();
    clientNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        //Recuperação das observações e número de pedido do cliente, se existir
        if (widget.obsText != null) {
          obsController.text = widget.obsText;
        }
        if (widget.clientOrderNumber != null) {
          clientNumberController.text = widget.clientOrderNumber;
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
                          if (newItens != null) {
                            setState(() {
                              currentItems = newItens;
                            });
                          }
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
                                //Função para deletar item (independente da quantidade) do pedido
                                //Se for o único item do pedido, o pedido será cancelado
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
                              final aux = await _regrasTipoMovimento();
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
                                  '${DataHelper.brNumber.format(currentWeight())} kg',
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
                    //Função utilizada para salvar o pedido
                    FocusScope.of(context).unfocus();
                    var newOrder = PedidoMestre(
                      nUMEROSFA: userdata.vendedor.pROXIMOPED,
                      cLIENTE: widget.cliente.cLIENTE,
                      cONDPAGTO: widget.cliente.cONDPAGTO,
                      vENDEDOR: userdata.vendedor.vENDEDOR,
                      dTPED: DateFormat('yyyyMMdd')
                          .format(DateTime.now()), //data do dia do pedido
                      nROLISTA: widget.cliente.pRIORIDADE.toString(),
                      tIPOCLI: widget.cliente.tIPOCLI,
                      vLRPED: currentTotal(),
                      cARGATOTAL: currentWeight(),
                      nOMECLIENTE: widget.cliente.nOMFANTASIA,
                      tEXTOESP: obsController.text,
                      rESERVADO2: int.parse(widget.cliente.tIPOMOVIMENTO
                          .tIPOMOVTO), //Anterior: 0 //Atual: Tipo de movimento do cliente widget.cliente.tIPOMOVIMENTO.tIPOMOVTO
                      // rESERVADO13: clientNumberController.text,
                      iTENSDOPEDIDO:
                          _toPedidoItem(userdata.vendedor.pROXIMOPED, date),
                    );
                    if (widget.isSaved) {
                      userdata.removeOrder(widget.currentOrder);
                    }
                    userdata.saveOrder(newOrder);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  sendFunction: () async {
                    //Função utilizada para enviar o pedido
                    FocusScope.of(context).unfocus();
                    setState(() {
                      showSpinner = true;
                    });
                    final String urlMestre = userdata.baseUrl + 'PedidoMestre';
                    final String urlItens = userdata.baseUrl + 'PedidoItens';
                    try {
                      //Adaptação do Pedido Mestre para a sintaxe requisitada do POST Request
                      await userdata.updateVendedor();
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
                                'DT_PED': DateFormat('yyyyMMdd').format(
                                    DateTime.now()), //data do dia do pedido
                                'VLR_PED': currentTotal(),
                                'CARGA_TOTAL': currentWeight(),
                                'NRO_LISTA':
                                    widget.cliente.pRIORIDADE.toString(),
                                'TIPO_CLI': widget.cliente.tIPOCLI,
                                'RESERVADO2': int.parse(widget
                                    .cliente
                                    .tIPOMOVIMENTO
                                    .tIPOMOVTO), //Anterior: 0 //Atual: Tipo de movimento do cliente widget.cliente.tIPOMOVIMENTO.tIPOMOVTO
                              }
                            ],
                          },
                        ],
                      );
                      List<dynamic> formattedItens = [];
                      //Adaptação dos Pedidos Item para a sintaxe requisitada do POST Request
                      for (var item in _toPedidoItem(
                          userdata.vendedor.pROXIMOPED, date)) {
                        formattedItens.add({
                          'NUMERO_SFA': userdata.vendedor.pROXIMOPED,
                          'SEQUENCIA': item.sEQUENCIA,
                          'C_PROD_PALM': item.cPRODPALM,
                          'QTDE': item.qTDE,
                          'VLR_UNIT': item.vLRUNIT,
                          'VLR_TOTAL': item.vLRTOTAL,
                          'DT_ENTREGA': item
                              .dTENTREGA, //data de entrega prevista do pedido
                          'UNIDADE': item.uNIDADE,
                          'TES': widget.cliente.tIPOMOVIMENTO.tIPOMOVTO,
                          'GRUPO': '', //não utilizável
                          'NRO_LISTA': item.nROLISTA,
                          'RESERVADO2': 0, //não incube ao app
                          'RESERVADO5': 0, //não incube ao app
                          'RESERVADO13': clientNumberController
                              .text, //Número de pedido do cliente
                          'RESERVADO14': DateFormat('yyyyMMdd')
                              .format(DateTime.now()), //data do dia do pedido
                          'RESERVADO15': '', //não incube ao app
                          'RESERVADO16':
                              widget.cliente.cLIENTE, //Código do cliente
                        });
                      }
                      var bodyItens = jsonEncode(
                        [
                          {
                            'MBPD': formattedItens,
                          },
                        ],
                      );
                      print(bodyMestre);
                      print(bodyItens);
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
