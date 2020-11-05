import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/components/search_box.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/screens/pedidos/order_confirm.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../data_helper.dart';
import '../../user_data.dart';
import 'order_widgets.dart';

class NewOrderScreen extends StatefulWidget {
  final Cliente cliente;
  NewOrderScreen(this.cliente);
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  Iterable<Produto> _productQuery(UserData userdata, String search, int key) {
    Iterable<Produto> query = [];

    query = userdata.produtos;

    if (search != null || search != '') {
      query = query.where((element) =>
          element.dESCRICAO.contains(search) ||
          element.cPRODPALM.contains(search));
    }

    userdata.atribuirPreco(key);

    query = query.where((element) => element.pRECO != null);

    return query;
  }

  List<CartItem> _confirmedItems(List<CartItem> items) {
    List<CartItem> aux = [];
    for (var item in items) {
      if (item.amount > 0) {
        aux.add(item);
      }
    }
    return aux;
  }

  String search = '';

  @override
  void initState() {
    super.initState();
    Provider.of<UserData>(context, listen: false).cartItems.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            elevation: 0,
            title: Text('Novo Pedido'),
          ),
          body: Column(
            children: [
              SearchBox(
                onChanged: (value) {
                  setState(() {
                    search = value.toString().toUpperCase();
                  });
                },
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(15, 25, 15, 10),
                    itemCount: _productQuery(
                            userdata, search, widget.cliente.pRIORIDADE)
                        .length,
                    itemBuilder: (context, index) {
                      var item = _productQuery(
                              userdata, search, widget.cliente.pRIORIDADE)
                          .elementAt(index);
                      userdata.addItem(item);
                      var cartView = CartView(
                          item: item, cartItem: userdata.cartItems[index]);
                      return cartView;
                    },
                  ),
                ),
              ),
              Container(
                height: 35,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Total: R\$ ${DataHelper.brNumber.format(userdata.getTotal())}',
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4B000000),
                      blurRadius: 1.5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              OrderConfirmButton(
                label: 'CONTINUAR',
                onPressed: () {
                  var confirmedItems = _confirmedItems(userdata.cartItems);
                  if (confirmedItems.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderConfirm(
                                confirmedItems, userdata.getTotal())));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
