import 'package:flutter/material.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_widgets.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../data_helper.dart';

class OrderConfirm extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final Cliente cliente;
  OrderConfirm(this.items, this.total, this.cliente);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar pedido'),
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
                      return FinalItem(item: widget.items[index]);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Data da entrega',
                      style: kHeaderText.copyWith(color: Colors.blueGrey[400]),
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
                        setState(() {
                          date = aux;
                        });
                      },
                      child: Text(date.toString()),
                      color: Colors.grey[200],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'Resumo do pedido',
                      style: kHeaderText.copyWith(color: Colors.blueGrey[400]),
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
                        title: 'Total:',
                        description:
                            'R\$ ${DataHelper.brNumber.format(widget.total)}',
                        colour: Colors.blueGrey[700],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          TotalSummary(value: DataHelper.brNumber.format(widget.total)),
          OrderConfirmButton(
            label: 'FECHAR PEDIDO',
          ),
        ],
      ),
    );
  }
}
