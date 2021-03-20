import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/components/search_box.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/screens/pedidos/order_widgets.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../user_data.dart';

//Tela que controla edição de pedido que já foi salvo (saved_order)
//Praticamente uma réplica do new_order_screen.dart com tratamentos específicos para controle do arquivo salvo

class EditOrderScreen extends StatefulWidget {
  final Cliente cliente;
  final List<CartItem> cartItems;
  EditOrderScreen(this.cliente, this.cartItems);
  @override
  _EditOrderScreenState createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  Iterable<Produto> _productQuery(UserData userdata, String search, int key) {
    //Função para mostrar os elementos desejados na pesquisa
    //Como padrão mostra todos elementos
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

  Future<bool> _orderCancel() {
    //Função do WillPopScope
    //Confirmação do usuário de cancelamento da edição
    //Ao cancelar, o pedido será revertido para como estava anteriormente

    return Alert(
      context: context,
      title: 'AVISO',
      desc:
          'Ao sair desta operação, o pedido não será alterado. Deseja continuar?',
      style: kAlertCardStyle,
      buttons: [
        AlertButton(
            label: 'Não',
            line: Border.all(color: Colors.grey[600]),
            labelColor: Colors.grey[600],
            hasGradient: false,
            cor: Colors.white,
            onTap: () {
              Navigator.pop(context, false);
            }),
        AlertButton(
            label: 'Sim',
            onTap: () {
              Provider.of<UserData>(context, listen: false)
                  .getCart(widget.cartItems, backup: true);
              Navigator.pop(context, true);
            }),
      ],
    ).show();
  }

  String search = '';

  @override
  void initState() {
    //A tela precisa recuperar para o carrinho os itens do pedido
    super.initState();
    Provider.of<UserData>(context, listen: false).cart.clear();
    Provider.of<UserData>(context, listen: false).getCart(widget.cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        return WillPopScope(
          onWillPop: _orderCancel,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              elevation: 0,
              title: Text('Editar Pedido'),
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
                        var cartView = CartView(item: item);
                        return cartView;
                      },
                    ),
                  ),
                ),
                TotalSummary(
                    value: DataHelper.brNumber.format(userdata.getTotal())),
                OrderConfirmButton(
                  label: 'CONTINUAR',
                  onPressed: () {
                    if (userdata.cart.isNotEmpty) {
                      List<CartItem> cartItens = userdata.cart.values.toList();
                      Provider.of<UserData>(context, listen: false)
                          .cart
                          .clear();
                      Navigator.pop(context, cartItens);
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
