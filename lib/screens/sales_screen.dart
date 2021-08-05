import 'package:flutter/material.dart';
import 'landing_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SalesScreen extends StatelessWidget {
  final String id = '/SalesScreen';
  final String productId;
  final String productDesc;
  final String rate;

  SalesScreen({
    this.productId,
    this.productDesc,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    productsChosenForSale.add(productId);
    if (productsChosenForSale.length > 1) {
      print('Add the rate');
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
            ),
            onPressed: () {
              productsChosenForSale.clear();
              Navigator.of(context).pop();
            },
          ),
          title: Text('Sales'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: Text('Bill No: ' + productId)),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: productsChosenForSale.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Container(
                      child: Text(productsChosenForSale[index]),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity : ${productsChosenForSale.length}'),
                Text('Total Price : ' + rate),
              ],
            ),
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
