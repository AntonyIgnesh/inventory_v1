import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('View Products'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('View Page'),
        ),
      ),
    );
  }
}
