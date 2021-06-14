import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_v1/constants.dart';
import 'package:inventory_v1/widgets/add_products_text_field.dart';
import 'package:inventory_v1/widgets/toast.dart';
import 'package:inventory_v1/material_sizes_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _fireStore = FirebaseFirestore.instance;
List<DropdownMenuItem<String>> sizeListFromFireStore = [];

class AddProductsScreen extends StatefulWidget {
  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  TextEditingController productIdController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  int rate = 1;
  String size;
  bool showLoading = false;

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
        setState(() {
          size = sizeListFromFireStore.first.value;
        });
      } else {
        print('Nothing fetched');
      }
    } catch (e) {
      print(e);
      print('Error in Getting Sizes from Firebase');
    }
  }

  // List<DropdownMenuItem> getSizeList() {
  //   List<DropdownMenuItem<String>> sizeItems = [];
  //   for (String sizes in sizeList) {
  //     var newItem = DropdownMenuItem(
  //       child: Text(
  //         sizes,
  //         style: kAddProductSizesStyle,
  //       ),
  //       value: sizes,
  //     );
  //     sizeItems.add(newItem);
  //   }
  //   return sizeItems;
  // }

  @override
  void initState() {
    super.initState();
    setState(() => showLoading = true);
    getSizesFromFireBase();
    setState(() => showLoading = false);
  }

  @override
  void deactivate() {
    sizeListFromFireStore.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    sizeController.text = size;
    rateController.text = rate.toString();
    rateController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: rateController.text.length,
      ),
    );
    // height: MediaQuery.of(context).size.height * 0.75,
    return ModalProgressHUD(
      inAsyncCall: showLoading,
      child: Container(
        decoration: BoxDecoration(
          color: kbottomSheetBackgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        // constraints: BoxConstraints(
        //   maxHeight: MediaQuery.of(context).size.height * 0.5,
        // ),
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Add Product',
                style: kAddProductsTextStyle,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: AddProductsTextField(
                            maxLines: 1,
                            lableTextForTextField: 'Product ID',
                            onChangeFunction: (value) {
                              productIdController.text = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: AddProductsTextField(
                            lableTextForTextField: 'Description',
                            textInputType: TextInputType.multiline,
                            maxLines: 4,
                            onChangeFunction: (value) {
                              productDescriptionController.text = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Size:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              DropdownButton<String>(
                                iconEnabledColor: Colors.black,
                                dropdownColor: kbottomSheetBackgroundColor,
                                value: sizeController.text,
                                items: sizeListFromFireStore,
                                onChanged: (value) {
                                  setState(() {
                                    size = value;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.minus,
                                    color: kCardColor,
                                  ),
                                  onPressed: rate <= 1
                                      ? null
                                      : () {
                                          setState(() {
                                            rate = rate - 1;
                                          });
                                        },
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: AddProductsTextField(
                                  lableTextForTextField: 'Rate',
                                  onChangeFunction: (value) {
                                    setState(() {
                                      rate = int.parse(value);
                                    });
                                  },
                                  controller: rateController,
                                  textInputType: TextInputType.number,
                                ),
                              ),
                              InkWell(
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.plus,
                                    color: kCardColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      rate = rate + 1;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 17.0,
                              ),
                              child: FloatingActionButton(
                                backgroundColor: kCardColor,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  ShowingToast(context: context)
                                      .showSuccessToast("Product " +
                                          productIdController.text +
                                          " added Successfully");
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
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
