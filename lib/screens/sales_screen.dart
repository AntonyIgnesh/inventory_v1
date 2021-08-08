import 'package:flutter/material.dart';
import 'landing_screen.dart';
import 'package:inventory_v1/controller/firebase_networks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_v1/constants.dart';
import 'checkout_screen.dart';
import 'package:inventory_v1/widgets/toast.dart';

class SalesScreen extends StatelessWidget {
  final String id = '/SalesScreen';
  final String productId;
  final String productDesc;
  final String rate;
  double totalPrice = 0.0;

  SalesScreen({
    this.productId,
    this.productDesc,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    if (productId != null) {
      productsChosenForSale.add(productId);
    }
    if (rate != null) {
      productRatesChosenForSale.add(rate);
      if (productRatesChosenForSale.length > 1) {
        for (String rateInList in productRatesChosenForSale) {
          totalPrice = totalPrice + double.parse(rateInList);
        }
      } else {
        totalPrice = double.parse(productRatesChosenForSale[0]);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        productsChosenForSale.clear();
        productRatesChosenForSale.clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
              ),
              onPressed: () {
                productsChosenForSale.clear();
                productRatesChosenForSale.clear();
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    finalNewBillNumber != null
                        ? 'Bill No: ' + finalNewBillNumber
                        : 'Bill No: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              productId != null
                  ? Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: productsChosenForSale.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                child: Card(
                                  color: kCardColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          productsChosenForSale[index],
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.rupeeSign,
                                              size: 14,
                                            ),
                                            Text(
                                              productRatesChosenForSale[index],
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: Text(''),
                    ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 35,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productId != null
                          ? 'Quantity : ${productsChosenForSale.length}'
                          : 'Quantity : 0',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Total Price : $totalPrice',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 25.0,
                ),
                child: MaterialButton(
                  child: Text(
                    'PROCEED TO CHECKOUT',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  height: 40,
                  textColor: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    if (productsChosenForSale.length > 0) {
                      Route route = MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          billNumber: finalNewBillNumber,
                          totalPrice: totalPrice,
                        ),
                      );
                      Navigator.push(context, route);
                    } else {
                      ShowingToast(context: context).showFailureToast(
                        'No products added to sell',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
