import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/pedidoItem.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/edit_order_screen.dart';
import 'package:vendasagrindus/screens/pedidos/order_widgets.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../data_helper.dart';

class OrderSummaryScreen extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final double pesoTotal;
  final Cliente cliente;
  final bool isSaved;
  final String obsText;
  final int currentOrder;
  OrderSummaryScreen(this.items, this.total, this.pesoTotal, this.cliente,
      {this.isSaved = false, this.obsText, this.currentOrder});

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState(items);
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  _OrderSummaryScreenState(this.currentItems);

  List<CartItem> currentItems = List<CartItem>();
  DateTime date = DateTime.now();
  TextEditingController obs = TextEditingController(text: "");
  List<PedidoItem> _toPedidoItem(String numeroSFA, DateTime date) {
    List<PedidoItem> aux = [];
    int sequencia = 1;
    for (var item in currentItems) {
      aux.add(
        PedidoItem(
          nUMEROSFA: numeroSFA,
          sEQUENCIA: sequencia.toString(),
          cPRODPALM: item.code,
          qTDE: item.amount.toString(),
          vLRUNIT: DataHelper.brNumber.format(item.price),
          vLRTOTAL: DataHelper.brNumber.format(item.total),
          dTENTREGA: date.toString(),
          nROLISTA: widget.cliente.pRIORIDADE.toString(),
          dESCRICAO: item.name,
          cODBARRA: item.barCode,
          iMAGE: item.image,
          pESO: item.weight,
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
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        return Scaffold(
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
                                        line:
                                            Border.all(color: Colors.grey[600]),
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
                                  desc: 'Deseja remover este item do carrinho?',
                                  style: kAlertCardStyle,
                                  buttons: [
                                    AlertButton(
                                        label: 'Não',
                                        line:
                                            Border.all(color: Colors.grey[600]),
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
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Data da entrega',
                          style:
                              kHeaderText.copyWith(color: Colors.blueGrey[400]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: FlatButton(
                          onPressed: () async {
                            final aux = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: date,
                                lastDate: DateTime(date.year + 4));
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
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          'Resumo do pedido',
                          style:
                              kHeaderText.copyWith(color: Colors.blueGrey[400]),
                        ),
                      ),
                      DetailsCard(
                        items: [
                          DetailItem(
                            title: 'Condição do pagamento:',
                            description:
                                '${widget.cliente.cONDPAGTO} - ${widget.cliente.cONDPAGTOobj.dESCRICAO}',
                            colour: Colors.blueGrey[700],
                          ),
                          DetailItem(
                            title: 'Tipo de pagamento:',
                            description: '',
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
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          'Observações finais',
                          style:
                              kHeaderText.copyWith(color: Colors.blueGrey[400]),
                        ),
                      ),
                      NotesBox(controller: obs),
                    ],
                  ),
                ),
              ),
              TotalSummary(value: DataHelper.brNumber.format(currentTotal())),
              OrderConfirmButton(
                label: 'SALVAR PEDIDO',
                onPressed: () {
                  if (widget.isSaved) {
                    userdata.removeOrder(widget.currentOrder);
                  }
                  var newOrder = PedidoMestre(
                    nUMEROSFA: userdata.vendedor.pROXIMOPED,
                    cLIENTE: widget.cliente.cLIENTE,
                    cONDPAGTO: widget.cliente.cONDPAGTO,
                    vENDEDOR: userdata.vendedor.vENDEDOR,
                    dTPED: date.toString(),
                    nROLISTA: widget.cliente.pRIORIDADE.toString(),
                    tIPOCLI: widget.cliente.tIPOCLI,
                    vLRPED: DataHelper.brNumber.format(currentTotal()),
                    nOMECLIENTE: widget.cliente.nOMFANTASIA,
                    tEXTOESP: obs.text,
                    pESOTOTAL: currentWieght(),
                    iTENSDOPEDIDO:
                        _toPedidoItem(userdata.vendedor.pROXIMOPED, date),
                  );
                  userdata.saveOrder(newOrder);

                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
