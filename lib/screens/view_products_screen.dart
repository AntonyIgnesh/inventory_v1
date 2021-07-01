import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';
import 'package:inventory_v1/widgets/products_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_v1/controller/firebase_networks.dart';
import 'package:inventory_v1/screens/product_details_screen.dart';
import 'package:inventory_v1/widgets/toast.dart';
import 'package:inventory_v1/widgets/view_products_size_list.dart';

List<Widget> sizesHorizontalList;

class ViewProductsScreen extends StatefulWidget {
  final String id = '/viewProductsScreen';
  @override
  _ViewProductsScreenState createState() => _ViewProductsScreenState();
}

class _ViewProductsScreenState extends State<ViewProductsScreen> {
  @override
  void initState() {
    super.initState();
    getSizesList();
  }

  String tempVal = '';
  int productsListedBelow = 0;

  onSearching(String value) {
    tempVal = value;
    setState(() {});
  }

  getSizesList() {
    if (sizeFromFireStore != null) {
      sizesHorizontalList = [];
      for (String sizeForList in sizeFromFireStore.data().values) {
        var newItem = GestureDetector(
          onTap: () {
            print(sizeForList);
            setState(() {});
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white54,
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  sizeForList,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
        sizesHorizontalList.add(newItem);
      }
      print('inside if' + sizesHorizontalList.toString());
    } else {
      sizesHorizontalList = [];
      for (String sizeForList in sizeFromFireStore.data().values) {
        var newItem = Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          elevation: 6,
          child: Text(
            sizeForList,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
        sizesHorizontalList.add(newItem);
      }
      print('inside else' + sizesHorizontalList.toString());
    }
  }

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
              Text(
                'Showing ${productsListedBelow != null ? productsListedBelow : 0} products',
              ),
              StreamBuilder<QuerySnapshot>(
                stream: getFireStoreInstanceStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Loading...'),
                    );
                  }
                  final productsFromFireStore = snapshot.data.docs;
                  List<Dismissible> productCardWidgets = [];
                  productsListedBelow = 0;
                  for (var product in productsFromFireStore) {
                    final productId = product.get('ProductId');
                    final productDesc = product.get('ProductDescription');
                    final productAddDate = product.get('ProductAddDate');
                    final productAddMonth = product.get('ProductAddMonth');
                    final productAddYear = product.get('ProductAddYear');
                    final size = product.get('Size');
                    final rate = product.get('Rate');
                    final timestamp = product.get('Timestamp');

                    if (productId
                            .toString()
                            .toLowerCase()
                            .contains(tempVal.toLowerCase()) ||
                        productDesc
                            .toString()
                            .toLowerCase()
                            .contains(tempVal.toLowerCase()) ||
                        size
                            .toString()
                            .toLowerCase()
                            .contains(tempVal.toLowerCase())) {
                      productsListedBelow += 1;
                      final productCardWidget = Dismissible(
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                                backgroundColor: kCardColor,
                                title: Text(
                                  'Confirm',
                                  style: TextStyle(fontSize: 20),
                                ),
                                contentPadding: EdgeInsets.only(top: 10.0),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: Text(
                                          'Are you sure you wish to delete $productId Product?',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .pop(false),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'CANCEL',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .pop(true),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  32.0)),
                                                ),
                                                child: Text(
                                                  'DELETE',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        direction: DismissDirection.endToStart,
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'DELETE',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.delete_forever,
                              size: 35,
                            )
                          ],
                        ),
                        key: Key(product.id),
                        onDismissed: (direction) async {
                          await deleteProductFromFireStoreWithProductId(
                              productId);
                          ShowingToast(context: context).showSuccessToast(
                              "Product " + productId + " deleted Successfully");
                        },
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          child: ProductsCard(
                            productId: productId,
                            productDesc: productDesc,
                            productAddDate: productAddDate,
                            productAddMonth: productAddMonth,
                            productAddYear: productAddYear,
                            size: size,
                            rate: rate,
                          ),
                          onTap: () {
                            Route route = MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                productId: productId,
                                productDesc: productDesc,
                                productAddDate: productAddDate,
                                productAddMonth: productAddMonth,
                                productAddYear: productAddYear,
                                size: size,
                                rate: rate,
                              ),
                            );
                            Navigator.push(context, route);
                          },
                        ),
                      );
                      productCardWidgets.add(productCardWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: productCardWidgets,
                    ),
                  );
                },
              ),
              ViewProductsSizeList(
                sizeList: sizesHorizontalList,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          onSearching(value);
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration:
                            kViewProductsSearchProductTextFieldDecoration,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.filter_list,
                    //     size: 35,
                    //   ),
                    // ),
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
