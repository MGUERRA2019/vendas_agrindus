import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/components/search_box.dart';
import 'package:vendasagrindus/model/clientes.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../user_data.dart';

class NewOrderScreen extends StatefulWidget {
  Clientes cliente;
  NewOrderScreen(this.cliente);
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  List<Widget> _productQuery(
    UserData userdata,
    // int index,
    String search,
    // int key,
  ) {
    Iterable<Produto> query = [];
    List<Widget> queryView = [];

    // if (index == 0) {
    //   query = userdata.produtos;
    // } else {
    //   query = userdata.produtos.where(
    //       (element) => element.gRUPODESC == userdata.grupos[index].dESCRICAO);
    // }
    query = userdata.produtos;

    if (search != null || search != '') {
      query = query.where((element) =>
          element.dESCRICAO.contains(search) ||
          element.cPRODPALM.contains(search));
    }

    // userdata.atribuirPreco(key);

    for (var item in query) {
      int amount = 0;
      queryView.add(
        Container(
          height: 105,
          margin: EdgeInsets.all(5.5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(1.5),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: (item.iMAGEMURL != null)
                    ? CachedNetworkImage(
                        imageUrl: item.iMAGEMURL,
                        fit: BoxFit.fitHeight,
                        fadeInCurve: Curves.bounceIn,
                        fadeInDuration: Duration(milliseconds: 300),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image_not_supported_outlined),
                      )
                    : Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.black45,
                        size: 50,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.dESCRICAO,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          (item.dESCEXTENSO != null) ? item.dESCEXTENSO : '',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 4),
                      // item.pRECO != null
                      //     ? Text(
                      //         'R\$ ${DataHelper.brNumber.format(item.pRECO)}',
                      //         textAlign: TextAlign.center,
                      //       )
                      //     : Container(),
                      Container(
                        height: 50,
                        width: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (amount > 0) {
                                  setState(() {
                                    amount--;
                                  });
                                }
                              },
                              child: Container(
                                color: kPrimaryColor,
                                child: Icon(Icons.remove, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                amount.toString(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  amount++;
                                });
                              },
                              child: Container(
                                color: kPrimaryColor,
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return queryView;
  }

  Iterable<Produto> _productQuery2(UserData userdata, String search) {
    Iterable<Produto> query = [];

    query = userdata.produtos;

    if (search != null || search != '') {
      query = query.where((element) =>
          element.dESCRICAO.contains(search) ||
          element.cPRODPALM.contains(search));
    }
    return query;
  }

  String search = '';
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
                    itemCount: _productQuery2(userdata, search).length,
                    itemBuilder: (context, index) {
                      var item =
                          _productQuery2(userdata, search).elementAt(index);
                      return CartItem(item: item);
                    },
                  ),
                ),
              ),
              Container(
                height: 35,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Total: R\$ 32,00',
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
              Container(
                decoration: BoxDecoration(
                  gradient: kGradientStyle,
                ),
                height: 55,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'FECHAR PEDIDO',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: .7),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    @required this.item,
  });

  final Produto item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: EdgeInsets.all(5.5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(1.5),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: (item.iMAGEMURL != null)
                ? CachedNetworkImage(
                    imageUrl: item.iMAGEMURL,
                    fit: BoxFit.fitHeight,
                    fadeInCurve: Curves.bounceIn,
                    fadeInDuration: Duration(milliseconds: 300),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.image_not_supported_outlined),
                  )
                : Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.black45,
                    size: 50,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.dESCRICAO,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (item.dESCEXTENSO != null) ? item.dESCEXTENSO : '',
                          style: kDescriptionTextStyle,
                        ),
                        Text('Peso bruto: ${item.pESOBRUTO}',
                            style: kDescriptionTextStyle),
                        Text('Código do Produto: ${item.cPRODPALM}',
                            style: kDescriptionTextStyle)
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  // item.pRECO != null
                  //     ? Text(
                  //         'R\$ ${DataHelper.brNumber.format(item.pRECO)}',
                  //         textAlign: TextAlign.center,
                  //       )
                  //     : Container(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('R\$ 32,00'),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: kPrimaryColor, width: 1.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<UserData>(context, listen: false)
                                    .removerQtde(item);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(20)),
                                  color: kPrimaryColor,
                                ),
                                child: Icon(Icons.remove,
                                    color: Colors.white, size: 27.5),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                item.qTDEVENDA.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<UserData>(context, listen: false)
                                    .adicionarQtde(item);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(20)),
                                  color: kPrimaryColor,
                                ),
                                child: Icon(Icons.add,
                                    color: Colors.white, size: 27.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
