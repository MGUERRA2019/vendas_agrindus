import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    this.onChanged,
  });

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding, // 5 top and bottom
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            width: 14.0,
            height: 14.0,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }
}
