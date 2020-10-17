import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/components/search_box.dart';
import 'package:vendasagrindus/model/grupos.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import 'package:vendasagrindus/data_helper.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Widget> groupList = [];
  int selectedIndex = 0;
  String search = '';
  int currentList;

  List<DropdownMenuItem> _getDropdownItems(List<int> listNumber) {
    List<DropdownMenuItem<int>> list = [];
    for (var item in listNumber) {
      var newItem = DropdownMenuItem(
        child: Text(item.toString()),
        value: item,
      );
      list.add(newItem);
    }
    return list;
  }

  List<Widget> _productQuery(
      UserData userdata, int index, String search, int key) {
    Iterable<Produto> query = [];
    List<Widget> queryView = [];

    if (index == 0) {
      query = userdata.produtos;
    } else {
      query = userdata.produtos.where(
          (element) => element.gRUPODESC == userdata.grupos[index].dESCRICAO);
    }

    if (search != null || search != '') {
      query = query.where((element) =>
          element.dESCRICAO.contains(search) ||
          element.cPRODPALM.contains(search));
    }

    userdata.atribuirPreco(key);

    for (var item in query) {
      queryView.add(Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.dESCRICAO,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              item.cPRODPALM,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              item.pRECO != null
                  ? 'R\$ ${DataHelper.brNumber.format(item.pRECO)}'
                  : 'Preço não informado',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ));
    }

    return queryView;
  }

  @override
  void initState() {
    super.initState();
    currentList =
        Provider.of<UserData>(context, listen: false).listNumber.first;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userdata, child) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            elevation: 0,
            title: Text('Produtos'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.view_module),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.view_stream),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/filter.svg",
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Filtro',
                            textAlign: TextAlign.center,
                          ),
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            return Container(
                              width: 200,
                              height: 350,
                              child: ListView.builder(
                                  itemCount: userdata.grupos.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                        title: Text(
                                          userdata.grupos[index].dESCRICAO,
                                        ),
                                        value: index,
                                        groupValue: selectedIndex,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedIndex = value;
                                          });
                                        });
                                  }),
                            );
                          }),
                          actionsPadding: EdgeInsets.only(right: 80, bottom: 5),
                          actions: [
                            FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                color: kPrimaryColor,
                                onPressed: () {
                                  Navigator.pop(context, selectedIndex);
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        );
                      }).then((value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  });
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Flexible(
                      child: SearchBox(
                        onChanged: (value) {
                          setState(() {
                            search = value.toString().toUpperCase();
                          });
                        },
                      ),
                    ),
                    DropdownButton<int>(
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Colors.grey[850],
                        value: currentList,
                        items: _getDropdownItems(userdata.listNumber),
                        onChanged: (value) {
                          setState(() {
                            currentList = value;
                          });
                        }),
                    SizedBox(width: 15),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius:
                    //     BorderRadius.vertical(top: Radius.circular(40))
                  ),
                  child: GridView(
                    padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    children: _productQuery(
                        userdata, selectedIndex, search, currentList),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
