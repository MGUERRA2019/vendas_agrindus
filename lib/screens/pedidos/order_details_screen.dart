import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/pedidoItem.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class OrderDetailsScreen extends StatelessWidget {
  final PedidoMestre pedidoMestre;
  final List<PedidoItem> pedidosItem;
  OrderDetailsScreen(this.pedidoMestre, this.pedidosItem);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailsCard(
            items: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Pedido ${pedidoMestre.nUMEROSFA}',
                    style: kHeaderText.copyWith(color: Colors.blueGrey[400]),
                  ),
                ),
              ),
              DetailItem(
                title: 'Condição de pagamento:',
                description: pedidoMestre.cONDPAGTO,
                colour: Colors.blueGrey[700],
              ),
              DetailItem(
                title: 'Tipo de pagamento:',
                description: '',
                colour: Colors.blueGrey[700],
              ),
              DetailItem(
                title: 'Tipo de movimento:',
                description: '',
                colour: Colors.blueGrey[700],
              ),
              DetailItem(
                title: 'Tipo de pedido:',
                description: pedidoMestre.tIPOPED,
                colour: Colors.blueGrey[700],
              ),
              DetailItem(
                title: 'Emissão:',
                description: pedidoMestre.dTPED.toString(),
                colour: Colors.blueGrey[700],
              ),
              DetailItem(
                title: 'Status:',
                description: pedidoMestre.sTATUS,
                colour: Colors.blueGrey[700],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
            child: Text(
              'Itens do pedido',
              style: kHeaderText.copyWith(color: Colors.blueGrey[300]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: pedidosItem.length,
              itemBuilder: (context, index) {
                return DetailsCard(
                  items: [
                    DetailItem(
                        title: 'Sequência:',
                        description: pedidosItem[index].sEQUENCIA),
                    DetailItem(
                        title: 'Código do Produto:',
                        description: pedidosItem[index].cPRODPALM),
                    DetailItem(
                        title: 'Quantidade:',
                        description: pedidosItem[index].qTDE),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
