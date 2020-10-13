import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class DetailsCard extends StatelessWidget {
  final List<Widget> items;
  DetailsCard({this.items});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: kCardShadow, blurRadius: 15, spreadRadius: 6)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String description;
  DetailItem({@required this.title, @required this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: description));
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Texto copiado para a área de transferência.'),
                  duration: Duration(milliseconds: 1500),
                ));
              },
              child: Text((description == null) ? '' : description,
                  style: TextStyle(fontFamily: 'Roboto')),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsHeader extends StatelessWidget {
  final String title;
  DetailsHeader({@required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: HeaderDelegate(title),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  HeaderDelegate(this.title);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kCardShadow,
            blurRadius: 3,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black38,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 65;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
