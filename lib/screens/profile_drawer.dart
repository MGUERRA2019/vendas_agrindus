import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../user_data.dart';
import 'login/login_screen.dart';

//Widget responsável pelo acesso das configurações do usuário, como o logout

class ProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    FirebaseAuth.instance.currentUser.displayName,
                    style: kHeaderText,
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: Text('Configurações'),
            leading: Icon(Icons.settings),
            children: [
              ListTile(
                title: Text('Minha conta'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Configurações do app'),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            title: Text('Desconectar'),
            leading: Icon(Icons.logout),
            onTap: () {
              Alert(
                context: context,
                title: 'DESCONECTAR',
                image: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.blue[800],
                    size: 50.0,
                  ),
                ),
                desc:
                    'Ao desconectar, todos pedidos salvos serão excluídos. Deseja prosseguir?',
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
                      onTap: () async {
                        await Provider.of<UserData>(context, listen: false)
                            .signOut();
                        await FirebaseAuth.instance.signOut().whenComplete(() =>
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false));
                      }),
                ],
              ).show();
            },
          ),
        ],
      ),
    );
  }
}
