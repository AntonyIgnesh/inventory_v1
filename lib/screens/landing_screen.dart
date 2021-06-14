import 'package:flutter/material.dart';
import 'package:inventory_v1/widgets/reusable_card.dart';
import 'package:inventory_v1/constants.dart';
import 'total_asset_screen.dart';
import 'add_products_screen.dart';
import 'package:inventory_v1/widgets/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() => print('FireBase is UP'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Mangal\'s Inventory',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReuseableCard(
                      colour: kCardColor,
                      cardChild: TotalAssetScreen(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/updateProductsScreen',
                              );
                            },
                            child: ReuseableCard(
                              colour: kCardColor,
                              cardChild: IconContent(
                                iconData: FontAwesomeIcons.syncAlt,
                                text: 'UPDATE',
                              ), //Update
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/viewProductsScreen',
                              );
                            },
                            child: ReuseableCard(
                              colour: kCardColor,
                              cardChild: IconContent(
                                iconData: FontAwesomeIcons.search,
                                text: 'VIEW',
                              ), //Search
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.black.withOpacity(0.0),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: AddProductsScreen(),
                                  ),
                                ),
                              );
                            },
                            child: ReuseableCard(
                              colour: kCardColor,
                              cardChild: IconContent(
                                iconData: FontAwesomeIcons.plus,
                                text: 'ADD',
                              ), //Add
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
