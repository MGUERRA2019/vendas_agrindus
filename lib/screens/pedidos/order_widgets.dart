import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../../data_helper.dart';
import '../../user_data.dart';

class TotalSummary extends StatelessWidget {
  //Widget que mostra o valor do pedido
  final String value;

  TotalSummary({this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Text(
        'Total: R\$ $value',
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
    );
  }
}

class OrderConfirmButton extends StatelessWidget {
  //Widget que direciona o pedido para a tela de resumo do pedido (order_summary_screen.dart)
  final String label;
  final Function onPressed;

  OrderConfirmButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: kGradientStyle,
        ),
        height: 55,
        width: double.infinity,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: .7),
          ),
        ),
      ),
    );
  }
}

class SummaryButton extends StatelessWidget {
  //Widget que definde se o pedido será salvo (saveFunction) ou enviado (sendFunction)
  final Function saveFunction;
  final Function sendFunction;

  SummaryButton({this.saveFunction, this.sendFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: saveFunction,
              child: Container(
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'SALVAR PEDIDO',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: .7),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: sendFunction,
              child: Container(
                decoration: BoxDecoration(
                  gradient: kGradientStyle,
                ),
                child: Center(
                  child: Text(
                    'ENVIAR PEDIDO',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: .7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartView extends StatelessWidget {
  //Widget que mostra todos produtos na tela para a formação do carrinho
  const CartView({@required this.item});

  final Produto item;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        return Container(
          height: 200,
          margin: EdgeInsets.all(5.5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[300]),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 1.5),
                height: 100,
                width: 100,
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
                              (item.dESCEXTENSO != null)
                                  ? item.dESCEXTENSO
                                  : '',
                              style: kDescriptionTextStyle,
                            ),
                            Text(
                                'Peso: ${DataHelper.brNumber.format(item.pesoTotal)} kg',
                                style: kDescriptionTextStyle),
                            Text('Qtde por embalagem: ${item.qDTEPEMBAL}',
                                style: kDescriptionTextStyle),
                            Text('Código do Produto: ${item.cPRODPALM}',
                                style: kDescriptionTextStyle),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          item.pRECO != null
                              ? Text(
                                  'R\$ ${DataHelper.brNumber.format(item.pRECO)}',
                                  textAlign: TextAlign.center,
                                )
                              : Container(),
                          AmountSelector(
                            item: item,
                            removeFunction: () {
                              userdata.removerQtde(item);
                            },
                            amountDisplay:
                                userdata.cart.containsKey(item.cPRODPALM)
                                    ? userdata.cart[item.cPRODPALM].amount
                                        .toString()
                                    : '0',
                            addFunction: () {
                              userdata.addCartItem(item);
                            },
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
      },
    );
  }
}

class FinalItem extends StatelessWidget {
  //Widget que mostra os itens do pedido no resumo (orders_summary_screen.dart)
  const FinalItem(
      {@required this.item,
      this.removeFunction,
      this.addFunction,
      this.changeCartAmount});

  final CartItem item;
  final void Function(int) changeCartAmount;
  final Function removeFunction;
  final Function addFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1.5, color: Colors.grey[300]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(1.5),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: (item.image != null)
                        ? CachedNetworkImage(
                            imageUrl: item.image,
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
                  Text(item.name),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'R\$ ${DataHelper.brNumber.format(item.price)}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          FinalItemText(label: 'Ref.: ${item.code}'),
          FinalItemText(label: 'Cod. Barra: ${item.barCode}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FinalItemText(
                  label:
                      'Peso: ${DataHelper.brNumber.format(item.pesoTotal)} kg'),
              AmountSelector(
                changeCartAmount: (amount) => changeCartAmount(amount),
                  removeFunction: removeFunction,
                  amountDisplay: item.amount.toString(),
                  addFunction: addFunction)
            ],
          ),
          SizedBox(height: 15),
          Divider(
            height: 0.0,
            color: Colors.grey[300],
            thickness: 1.5,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
            ),
            child: Text(
              'Quantidade: ${item.amount}',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class FinalItemText extends StatelessWidget {
  FinalItemText({@required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Text(
        label,
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }
}

class AmountSelector extends StatelessWidget {
  final Function removeFunction;
  final Function addFunction;
  final Produto item;
  final void Function(int) changeCartAmount;
  final String amountDisplay;

  AmountSelector(
      {@required this.removeFunction,
      @required this.amountDisplay,
      this.item,
      this.changeCartAmount,
      @required this.addFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryColor, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: removeFunction,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(20)),
                color: kPrimaryColor,
              ),
              child: Icon(Icons.remove, color: Colors.white, size: 27.5),
            ),
          ),
          GestureDetector(
            onLongPress: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                          child: Container(
                        child: AmountEditorSheet(
                          produto: item,
                          changeCartAmount: (amount) =>
                              changeCartAmount(amount),
                        ),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                      )));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                amountDisplay,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          GestureDetector(
            onTap: addFunction,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(20)),
                color: kPrimaryColor,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 27.5),
            ),
          ),
        ],
      ),
    );
  }
}

class AmountEditorSheet extends StatefulWidget {
  final Produto produto;
  final void Function(int) changeCartAmount;

  AmountEditorSheet({this.produto, this.changeCartAmount});

  @override
  _AmountEditorSheetState createState() => _AmountEditorSheetState();
}

class _AmountEditorSheetState extends State<AmountEditorSheet> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSheetBackground,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Alterar Quantidade",
              textAlign: TextAlign.center,
              style: kHeaderText.copyWith(color: kPrimaryColor),
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: controller,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              textAlign: TextAlign.center,
            ),
            FlatButton(
              onPressed: () {
                final amount = int.tryParse(controller.text);
                if (amount != null) {
                  if (widget.produto != null) {
                    Provider.of<UserData>(context, listen: false)
                        .addNumberedCartItem(widget.produto, amount);
                  } else {
                    widget.changeCartAmount(amount);
                  }
                }
                Navigator.pop(context);
              },
              child: Text(
                "ALTERAR",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotesBox extends StatelessWidget {
  //Caixa de notação para as observações do pedido e número do pedido do cliente
  const NotesBox(
      {@required this.controller,
      this.maxLines,
      this.maxLength,
      this.inputType,
      this.hintText});

  final TextEditingController controller;
  final int maxLines;
  final int maxLength;
  final TextInputType inputType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: kCardShadow, blurRadius: 15, spreadRadius: 6)
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        maxLength: maxLength,
        controller: controller,
        autofocus: false,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: .05)),
        ),
      ),
    );
  }
}

class SummaryHeader extends StatelessWidget {
  //Cabeçalho para cada widget no resumo do pedido (order_summary_screen.dart)
  final String headerText;
  final EdgeInsetsGeometry padding;

  SummaryHeader({@required this.headerText, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        headerText,
        style: kHeaderText.copyWith(color: Colors.blueGrey[400]),
      ),
    );
  }
}
