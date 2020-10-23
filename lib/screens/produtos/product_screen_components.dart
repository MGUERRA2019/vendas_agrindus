import 'package:flutter/material.dart';
import 'product_screen.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class GridItem extends StatelessWidget {
  GridItem({@required this.item});

  final Produto item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
              width: 125,
              height: 115,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                // item.iMAGEMURL != null ? Colors.white : Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              child: (item.iMAGEMURL != null)
                  ? CachedNetworkImage(
                      imageUrl: item.iMAGEMURL,
                      fit: BoxFit.fitHeight,
                      fadeInCurve: Curves.bounceIn,
                      fadeInDuration: Duration(milliseconds: 300),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.image_not_supported_outlined),
                    )
                  : Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.black45,
                      size: 50,
                    )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.dESCRICAO,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              item.pRECO != null
                  ? Text(
                      'R\$ ${DataHelper.brNumber.format(item.pRECO)}',
                      textAlign: TextAlign.center,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({@required this.item});

  final Produto item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      margin: EdgeInsets.all(5.5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(1.5),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: (item.iMAGEMURL != null)
                ? CachedNetworkImage(
                    imageUrl: item.iMAGEMURL,
                    fit: BoxFit.fitHeight,
                    fadeInCurve: Curves.bounceIn,
                    fadeInDuration: Duration(milliseconds: 300),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.image_not_supported_outlined),
                  )
                : Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.black45,
                    size: 50,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.dESCRICAO,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      (item.dESCEXTENSO != null) ? item.dESCEXTENSO : '',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 4),
                  item.pRECO != null
                      ? Text(
                          'R\$ ${DataHelper.brNumber.format(item.pRECO)}',
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListViewIcon extends StatelessWidget {
  final ViewType viewStyle;
  final ViewType currentView;
  final Function onPressed;
  final IconData icon;
  ListViewIcon(
      {@required this.viewStyle,
      @required this.currentView,
      @required this.onPressed,
      @required this.icon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: (viewStyle == ViewType.grid)
              ? BorderRadius.horizontal(left: Radius.circular(31))
              : BorderRadius.horizontal(right: Radius.circular(31)),
          color: (currentView == viewStyle) ? kPrimaryColor : Colors.white,
        ),
        padding: EdgeInsets.all(9),
        child: Icon(
          icon,
          color: (currentView == viewStyle) ? Colors.white : kPrimaryColor,
        ),
      ),
    );
  }
}
