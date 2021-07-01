import 'package:flutter/material.dart';

class ViewProductsSizeList extends StatelessWidget {
  final List<Widget> sizeList;
  ViewProductsSizeList({
    this.sizeList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: sizeList,
      ),
    );
  }
}
