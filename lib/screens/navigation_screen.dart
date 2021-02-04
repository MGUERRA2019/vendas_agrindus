import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/screens/clientes/lista_clientes.dart';
import 'package:vendasagrindus/screens/pedidos/order_list/order_list_screen.dart';
import 'package:vendasagrindus/screens/pedidos/saved_orders_screen.dart';
import 'package:vendasagrindus/screens/produtos/product_screen.dart';
import 'package:vendasagrindus/utilities/constants.dart';

//Tela de navegação do aplicativo
//É a tela inicial do aplicativo depois do login
//Aqui está disposto a barra de naveção e as telas disponíveis de primeiro acesso
//Todas as abas associadas a esta tela possuem o profile_drawer.dart

class NavigationScreen extends StatefulWidget {
  final int initialIndex;
  NavigationScreen({this.initialIndex = 0});
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static final _tabs = <Widget>[
    ListaClientes(),
    SavedOrdersScreen(),
    ProductScreen(),
    OrderListScreen(),
  ];

  Future<bool> _exitPressed() {
    return Alert(
      context: context,
      title: 'SAIR',
      image: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Icon(
          Icons.exit_to_app,
          color: Colors.blue[800],
          size: 50.0,
        ),
      ),
      desc: 'Você deseja mesmo sair do aplicativo?',
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
              Navigator.pop(context, true);
            }),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitPressed,
      child: Scaffold(
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
                Icons.folder_open_outlined,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.folder_open_outlined,
                color: Colors.white,
              ),
              title: Text('Salvos'),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.shopping_basket_outlined,
                color: Colors.white,
              ),
              title: Text('Produtos'),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.receipt_long_outlined,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.receipt_long_outlined,
                color: Colors.white,
              ),
              title: Text('Pedidos'),
            ),
          ],
          onTap: changePage,
        ),
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _tabs[currentIndex],
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
