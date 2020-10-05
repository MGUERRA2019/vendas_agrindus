import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:vendasagrindus/screens/clientes/lista_clientes.dart';
import 'package:vendasagrindus/screens/details/details_screen.dart';
import 'package:vendasagrindus/screens/produtos/produtos.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: kPrimaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        currentIndex: currentIndex,
        hasInk: true,
        inkColor: Colors.black12,
        hasNotch: true,
        opacity: 0.2,
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.people_outline,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.people_outline,
              color: Colors.white,
            ),
            title: Text('Clientes'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            title: Text('Novo Pedido'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.shopping_basket,
              color: Colors.white,
            ),
            title: Text('Produtos'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            title: Text('Perfil'),
          ),
        ],
        onTap: changePage,
      ),
      body: (currentIndex == 0)
          ? ListaClientes()
          : (currentIndex == 1)
              ? DetailsScreen()
              : (currentIndex == 2)
                  ? Produtos()
                  : Icon(
                      Icons.accessibility_new,
                      size: 140,
                    ),
    );
  }
}
