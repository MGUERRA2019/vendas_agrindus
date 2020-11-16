import 'package:flutter/material.dart';
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
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  DateTime date = DateTime.now();
  TextEditingController obs = TextEditingController();

  List<PedidoItem> _toPedidoItem(String numeroSFA, DateTime date) {
    List<PedidoItem> aux = [];
    int sequencia = 1;
    for (var item in widget.items) {
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditOrderScreen(
                                      widget.cliente, widget.items)));
                        }),
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
                        itemCount: widget.items.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FinalItem(
                              item: widget.items[index],
                              screenContext: context);
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
                          child: Text(date.toString()),
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
                                '${DataHelper.brNumber.format(widget.pesoTotal)} kg',
                            colour: Colors.blueGrey[700],
                          ),
                          DetailItem(
                            title: 'Total:',
                            description:
                                'R\$ ${DataHelper.brNumber.format(widget.total)}',
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
              TotalSummary(value: DataHelper.brNumber.format(widget.total)),
              OrderConfirmButton(
                label: 'SALVAR PEDIDO',
                onPressed: () {
                  if (widget.isSaved) {
                    userdata.saveFile();
                  } else {
                    var newOrder = PedidoMestre(
                      nUMEROSFA: userdata.vendedor.pROXIMOPED,
                      cLIENTE: widget.cliente.cLIENTE,
                      cONDPAGTO: widget.cliente.cONDPAGTO,
                      vENDEDOR: userdata.vendedor.vENDEDOR,
                      dTPED: date.toString(),
                      nROLISTA: widget.cliente.pRIORIDADE.toString(),
                      tIPOCLI: widget.cliente.tIPOCLI,
                      vLRPED: DataHelper.brNumber.format(widget.total),
                      nOMECLIENTE: widget.cliente.nOMFANTASIA,
                      tEXTOESP: obs.text,
                      pESOTOTAL: widget.pesoTotal,
                      iTENSDOPEDIDO:
                          _toPedidoItem(userdata.vendedor.pROXIMOPED, date),
                    );
                    userdata.saveOrder(newOrder);
                  }
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
