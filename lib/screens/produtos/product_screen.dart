import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/components/search_box.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/screens/profile_drawer.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/styles.dart';
import 'product_screen_components.dart';

enum ViewType {
  grid,
  list
} //enum para determinar o tipo de visualização dos produtos

//Tela de consulta dos produtos com lista de preços concernente ao vendedor

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ViewType currentView = ViewType
      .list; //Visualização dos produtos inicialmente estabelecida como lista
  List<Widget> groupList = [];
  int selectedIndex = 0;
  String search = '';
  int currentList;

  List<DropdownMenuItem> _getDropdownItems(List<int> listNumber) {
    //Função para recuperar os itens do DropDown Widget
    //Associa as listas de preços disponíveis ao vendedor
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

  Iterable<Produto> _productQuery(UserData userdata, int index, String search,
      int key, ViewType currentView) {
    //Função para mostrar os elementos desejados na pesquisa
    //Como padrão mostra todos elementos
    //A função também atribui preços aos itens
    Iterable<Produto> query = [];

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

    return query;
  }

  @override
  void initState() {
    super.initState();
    //inicialmente os produtos serão associados com a primeira lista de preços disponível ao vendedor
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
          ),
          drawer: ProfileDrawer(),
          body: Column(
            children: [
              SearchBox(
                onChanged: (value) {
                  setState(() {
                    search = value.toString().toUpperCase();
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5)),
                    child: Row(
                      children: [
                        ListViewIcon(
                          icon: Icons.view_stream_rounded,
                          viewStyle: ViewType.list,
                          currentView: currentView,
                          onPressed: () {
                            setState(() {
                              currentView = ViewType.list;
                            });
                          },
                        ),
                        ListViewIcon(
                          icon: Icons.view_module_rounded,
                          viewStyle: ViewType.grid,
                          currentView: currentView,
                          onPressed: () {
                            setState(() {
                              currentView = ViewType.grid;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Lista de preço:',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 3.5),
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
                                  content: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Container(
                                      width: 200,
                                      height: 350,
                                      child: ListView.builder(
                                          itemCount: userdata.grupos.length,
                                          itemBuilder: (context, index) {
                                            return RadioListTile(
                                                title: Text(
                                                  userdata
                                                      .grupos[index].dESCRICAO,
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
                                  actionsPadding:
                                      EdgeInsets.only(right: 80, bottom: 5),
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
                      SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  child: (currentView == ViewType.grid)
                      ? GridView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: _productQuery(userdata, selectedIndex,
                                  search, currentList, currentView)
                              .length,
                          itemBuilder: (context, index) {
                            var item = _productQuery(userdata, selectedIndex,
                                    search, currentList, currentView)
                                .elementAt(index);
                            return GridItem(item: item);
                          },
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
                          itemCount: _productQuery(userdata, selectedIndex,
                                  search, currentList, currentView)
                              .length,
                          itemBuilder: (context, index) {
                            var item = _productQuery(userdata, selectedIndex,
                                    search, currentList, currentView)
                                .elementAt(index);
                            return ListItem(item: item);
                          },
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
