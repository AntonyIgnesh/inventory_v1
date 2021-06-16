import 'package:flutter/material.dart';
import 'package:inventory_v1/widgets/reusable_card.dart';
import 'package:inventory_v1/constants.dart';
import 'total_asset_screen.dart';
import 'add_products_screen.dart';
import 'package:inventory_v1/widgets/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:intl/intl.dart';

final _fireStore = FirebaseFirestore.instance;
List<DropdownMenuItem<String>> sizeListFromFireStore = [];

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool showLoading = false;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() => print('FireBase is UP'));
  }

  Future getSizesFromFireBase() async {
    try {
      var sizeFromFireStore =
          await _fireStore.collection("productSizes").doc("sizes").get();
      if (sizeFromFireStore != null) {
        for (String sizeForList in sizeFromFireStore.data().values) {
          var newItem = DropdownMenuItem(
            child: Text(
              sizeForList,
              style: kAddProductSizesStyle,
            ),
            value: sizeForList,
          );
          sizeListFromFireStore.add(newItem);
        }
      } else {
        print('Nothing fetched');
      }
    } catch (e) {
      print(e);
      print('Error in Getting Sizes from Firebase');
    }
  }

  Future generateDocumentID() async {
    List<DocumentSnapshot> documents;
    List<String> productDocumentIdList = [];
    int lastAddedProductDocumentId;
    int newProductDocumentId;
    String finalProductDocumentId;
    var documentsFromFireStore = await _fireStore.collection("products").get();
    documents = documentsFromFireStore.docs;
    documents.forEach((data) {
      productDocumentIdList.add(data.id);
    });
    productDocumentIdList.sort();
    lastAddedProductDocumentId =
        int.parse(productDocumentIdList.last.substring(7));
    newProductDocumentId = lastAddedProductDocumentId + 1;

    finalProductDocumentId =
        'Product${newProductDocumentId.toString().padLeft(10, '0')}';
    print(finalProductDocumentId);

    // await _fireStore.collection('products').doc(finalProductDocumentId).set({
    //   'ProductId': '21JUN-00103',
    // });
  }

  Future generateProductID() async {
    List<String> productIdFromFireStore = [];
    DateTime dateUnformatted = DateTime.now();
    DateFormat dateFormatted = DateFormat('dd MMM yy');
    String fullDateNeeded = dateFormatted.format(dateUnformatted);

    var splitDate = fullDateNeeded.split(' ');
    String todayDate = splitDate[0];
    String todayMonth = splitDate[1];
    String todayYear = splitDate[2];

    var documentsWithDateFilterFromFireStore = await _fireStore
        .collection("products")
        .where(
          "ProductAddMonth",
          isEqualTo: todayMonth,
        )
        .where(
          'ProductAddYear',
          isEqualTo: todayYear,
        )
        .get();
    if (documentsWithDateFilterFromFireStore != null) {
      List<DocumentSnapshot> dateFilteredList =
          documentsWithDateFilterFromFireStore.docs;

      if (dateFilteredList.isNotEmpty) {
        dateFilteredList.forEach((receivedRecords) {
          productIdFromFireStore.add(receivedRecords.get('ProductId'));
        });
      } else {
        print('Nothing fetched');
      }
      productIdFromFireStore.sort();
      String lastAddedProductId = productIdFromFireStore.last;
      String lastAddedProductIdNumbersOnly = lastAddedProductId.substring(6);
      int lastAddedProductIdNumbersOnlyInt =
          int.parse(lastAddedProductIdNumbersOnly);
      int newProductIdInt = lastAddedProductIdNumbersOnlyInt + 1;
      String finalNewProductId = todayYear +
          todayMonth.toUpperCase() +
          '-' +
          newProductIdInt.toString().padLeft(5, '0');
      print(finalNewProductId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showLoading,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(
        color: Colors.white,
      ),
      child: SafeArea(
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
                              onTap: () async {
                                await generateProductID();
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
                              onTap: () async {
                                if (sizeListFromFireStore.isEmpty) {
                                  setState(() => showLoading = true);
                                  await getSizesFromFireBase();
                                  setState(() => showLoading = false);
                                }

                                showModalBottomSheet(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.0),
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
      ),
    );
  }
}
