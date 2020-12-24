import 'package:flutter/material.dart';
import 'package:vendasagrindus/screens/perfil/profile_widgets.dart';
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
          ],
        ),
      ),
    );
  }
}
