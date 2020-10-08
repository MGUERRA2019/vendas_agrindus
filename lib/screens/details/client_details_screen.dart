import 'package:flutter/material.dart';

class ClientDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blueAccent,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                snap: false,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(bottom: 60),
                  centerTitle: true,
                  title: Text(
                    'Bella Mamma',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[400], Colors.blueAccent[700]],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
                    ),
                  ),
                ),
                bottom: TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 0),
                  unselectedLabelColor: Colors.white,
                  labelColor: Color(0xFF4c73e6),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  tabs: [
                    Tab(
                      text: 'Dados Cadastrais',
                    ),
                    Tab(
                      text: 'Dados Financeiros',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            RegistrationDataScreen(),
            FinancialDataScreen(),
          ]),
        ),
      ),
    );
  }
}

class RegistrationDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        DetailsCard(title: 'RAZ_SOCIAL', description: 'A LEITERIA'),
        DetailsCard(title: 'Endereço', description: 'RUA PATROCINIO, 2153'),
        DetailsCard(title: 'Cidade', description: 'CIDADE'),
        DetailsCard(title: 'Estado', description: 'CAMPOS ELISEOS'),
        DetailsCard(title: 'CEP', description: '14085530'),
        DetailsCard(title: 'Telefone', description: '991745757'),
        DetailsCard(title: 'CGC_CPF', description: '187385880001'),
        DetailsCard(title: 'INSCR_ESTAD', description: '797387300118'),
      ],
    );
  }
}

class FinancialDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 20),
        DetailsCard(title: 'DT_PR_COMP', description: 'Aug  1 2018 12:00AM'),
        DetailsCard(title: 'DT_ULT_COMP', description: 'Sep 28 2020 12:00AM'),
        DetailsCard(title: 'DT_ULT_VISITA', description: 'Sep 30 2020 12:00AM'),
        DetailsCard(title: 'QT_DUP_PG', description: '14'),
        DetailsCard(title: 'SD_ATUAL', description: '72'),
        DetailsCard(title: 'VLR_ATRASOS', description: ''),
        DetailsCard(title: 'VLR_ACUM_VE', description: '2593'),
        DetailsCard(title: 'VLR_MA_FAT', description: '590'),
        DetailsCard(title: 'NRO_PG_ATR', description: '1'),
      ],
    );
  }
}

class DetailsCard extends StatelessWidget {
  final String title;
  final String description;
  DetailsCard({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 9),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.blueAccent, width: 2)),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.grey[600], width: 1.5)),
              child: Text(
                description,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
