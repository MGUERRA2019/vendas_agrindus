import 'package:flutter/material.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/screens/clientes/client_details_widgets.dart';
import 'package:vendasagrindus/screens/pedidos/order_widgets.dart';
import '../../data_helper.dart';

class OrderConfirm extends StatelessWidget {
  final List<CartItem> items;
  final double total;
  OrderConfirm(this.items, this.total);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                    itemCount: items.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FinalItem(item: items[index]);
                    },
                  ),
                  DetailsCard(
                    items: [
                      Center(
                        child: Text('info'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          OrderConfirmButton(
            label: 'FECHAR PEDIDO',
          ),
        ],
      ),
    );
  }
}
