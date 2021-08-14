import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_v1/constants.dart';
import 'package:inventory_v1/controller/firebase_networks.dart';
import 'landing_screen.dart';

List<Map<String, dynamic>> finalList = [];
List<String> productsChosenWhileListing = [];
List<String> productRatesChosenWhileListing = [];

class ListProductsForSaleScreen extends StatefulWidget {
  final String id = '/listProductsForSaleScreen';
  @override
  _ListProductsForSaleScreenState createState() =>
      _ListProductsForSaleScreenState();
}

class _ListProductsForSaleScreenState extends State<ListProductsForSaleScreen> {
  Color colorForCard = kCardColor;

  @override
  void initState() {
    finalList.clear();
    finalProductsToBeAvailForSelection();
    super.initState();
  }

  Widget checkIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Icon(
        Icons.check,
        size: 28,
      ),
    );
  }

  void finalProductsToBeAvailForSelection() {
    if (productsChosenForSale.length != 0) {
      for (int index = 0; index < productsListFromFireStore.length; index++) {
        if (!productsChosenForSale
            .contains(productsListFromFireStore[index]['ProductID'])) {
          finalList.add(
            {
              'ProductID': productsListFromFireStore[index]['ProductID'],
              'ProductDesc': productsListFromFireStore[index]['ProductDesc'],
              'Rate': productsListFromFireStore[index]['Rate'],
              'CardColor': kCardColor,
              'showCheckIcon': false,
            },
          );
        }
      }
    } else if (productsChosenForSale.length == 0) {
      for (int index = 0; index < productsListFromFireStore.length; index++) {
        finalList.add(
          {
            'ProductID': productsListFromFireStore[index]['ProductID'],
            'ProductDesc': productsListFromFireStore[index]['ProductDesc'],
            'Rate': productsListFromFireStore[index]['Rate'],
            'CardColor': kCardColor,
            'showCheckIcon': false,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        finalList.clear();
        productsChosenWhileListing.clear();
        productRatesChosenWhileListing.clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
              ),
              onPressed: () {
                finalList.clear();
                Navigator.of(context).pop();
              },
            ),
            title: Text('Select Products for Sale'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: finalList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (finalList[index]['CardColor'] == kCardColor) {
                              finalList[index]['CardColor'] =
                                  Colors.deepOrangeAccent;
                              finalList[index]['showCheckIcon'] = true;
                              productsChosenWhileListing
                                  .add(finalList[index]['ProductID']);
                              productRatesChosenWhileListing
                                  .add(finalList[index]['Rate']);
                            } else if (finalList[index]['CardColor'] ==
                                Colors.deepOrangeAccent) {
                              finalList[index]['CardColor'] = kCardColor;
                              finalList[index]['showCheckIcon'] = false;
                              productsChosenWhileListing
                                  .remove(finalList[index]['ProductID']);
                              productRatesChosenWhileListing
                                  .remove(finalList[index]['Rate']);
                            }
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          color: finalList[index]['CardColor'],
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    finalList[index]['showCheckIcon'] == true
                                        ? checkIcon()
                                        : Text(''),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Text(
                                            finalList[index]['ProductID']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            finalList[index]['ProductDesc']
                                                        .toString()
                                                        .length >
                                                    30
                                                ? finalList[index]
                                                            ['ProductDesc']
                                                        .toString()
                                                        .substring(0, 27) +
                                                    '...'
                                                : finalList[index]
                                                        ['ProductDesc']
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 14,
                                    ),
                                    Text(
                                      finalList[index]['Rate'].toString(),
                                      style: TextStyle(
                                        fontSize: finalList[index]['Rate']
                                                    .toString()
                                                    .length <
                                                4
                                            ? 18
                                            : 13,
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    for (String products in productsChosenWhileListing) {
                      productsChosenForSale.add(products);
                    }
                    for (String rates in productRatesChosenWhileListing) {
                      productRatesChosenForSale.add(rates);
                    }
                    Navigator.pop(context, setState(() {}));
                    productsChosenWhileListing.clear();
                    productRatesChosenWhileListing.clear();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      productsChosenWhileListing.length > 1
                          ? 'Selected ${productsChosenWhileListing.length} Products'
                          : 'Selected ${productsChosenWhileListing.length} Product',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
