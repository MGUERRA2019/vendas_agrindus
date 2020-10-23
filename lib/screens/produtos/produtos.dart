import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vendasagrindus/screens/produtos/components/body.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class Produtos extends StatefulWidget {
  @override
  _ProdutosState createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('Produtos'),
      ),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
