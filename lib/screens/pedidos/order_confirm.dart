import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/pedidoItem.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_widgets.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../data_helper.dart';

class OrderConfirm extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final double pesoTotal;
  final Cliente cliente;
  final bool isSaved;
  final String obsText;
  OrderConfirm(this.items, this.total, this.pesoTotal, this.cliente,
      {this.isSaved = false, this.obsText});

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  DateTime date = DateTime.now();
  TextEditingController obs = TextEditingController();

  List<Widget> appBarActions = [
    IconButton(icon: Icon(Icons.edit, color: Colors.white), onPressed: () {}),
    IconButton(icon: Icon(Icons.delete, color: Colors.white), onPressed: () {}),
  ];

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
            title: Text('Confirmar pedido'),
            actions: widget.isSaved ? appBarActions : null,
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
                      Container(
                        width: 100,
                        height: 100,
                        child: TextField(
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          controller: obs,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TotalSummary(value: DataHelper.brNumber.format(widget.total)),
              OrderConfirmButton(
                label: 'SALVAR PEDIDO',
                onPressed: () {
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
