import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/screens/login/login_screen.dart';
import 'package:vendasagrindus/screens/perfil/profile_widgets.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileBanner(),
            Divider(),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text('Estatísticas'),
              leading: Icon(Icons.stacked_bar_chart),
              children: [
                ListTile(
                  title: Center(child: Text('Content')),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Veja mais',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text('Configurações'),
              leading: Icon(Icons.settings),
              onTap: () {},
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
                          await FirebaseAuth.instance.signOut().whenComplete(
                              () => Navigator.pushAndRemoveUntil(
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
      ),
    );
  }
}
