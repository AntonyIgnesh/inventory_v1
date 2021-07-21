import 'package:flutter/material.dart';
import 'package:inventory_v1/widgets/products_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SalesScreen extends StatelessWidget {
  final String id = '/SalesScreen';
  final String productId;

  SalesScreen({
    this.productId,
  });

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
          title: Text('Sales'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text('Bill No: ' + productId),
            MaterialButton(
              color: Colors.deepPurpleAccent,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
