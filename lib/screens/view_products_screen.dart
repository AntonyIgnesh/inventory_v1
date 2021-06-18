import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';
import 'package:inventory_v1/widgets/products_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_v1/controller/firebase_networks.dart';

class ViewProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
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
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: allProductsList.length,
                    itemBuilder: CardBuilder,
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration:
                            kViewProductsSearchProductTextFieldDecoration,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_list,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
