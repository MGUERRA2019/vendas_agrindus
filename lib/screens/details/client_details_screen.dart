import 'package:flutter/material.dart';

class ClientDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.blueAccent,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              snap: false,
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border:
                                Border.all(color: Colors.blueAccent, width: 2)),
                        child: Text(
                          'Endereço',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: Text(
                          'RUA PATROCINIO, 2153',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ],
                  );
                },
                childCount: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  SliverFillRemaining(
//               child: TabBarView(children: [
//                 RegistrationDataScreen(),
//                 FinancialDataScreen(),
//               ]),
//             )

class RegistrationDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: Colors.blueAccent, width: 2)),
          child: Text(
            'Endereço',
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ),
        SizedBox(width: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: Colors.grey, width: 2)),
          child: Text(
            'RUA PATROCINIO, 2153',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

class FinancialDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Icon(
      Icons.attach_money,
      size: 200.0,
    )));
  }
}
