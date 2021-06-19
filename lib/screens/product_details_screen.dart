import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_v1/controller/firebase_networks.dart';
import 'package:inventory_v1/widgets/sizes_dropdown.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProductDetailsScreen extends StatefulWidget {
  bool showLoading = false;
  final String productId;
  String productDesc;
  final String productAddDate;
  final String productAddMonth;
  final String productAddYear;
  String size;
  String rate;

  ProductDetailsScreen({
    this.productId,
    this.productDesc,
    this.productAddDate,
    this.productAddMonth,
    this.productAddYear,
    this.size,
    this.rate,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  TextEditingController productDescriptionController = TextEditingController();

  TextEditingController rateController = TextEditingController();

  TextEditingController sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    productDescriptionController.text = widget.productDesc;
    rateController.text = widget.rate;
    sizeController.text = widget.size;
    productDescriptionController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: productDescriptionController.text.length,
      ),
    );
    rateController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: rateController.text.length,
      ),
    );
    return ModalProgressHUD(
      inAsyncCall: widget.showLoading,
      opacity: 0.1,
      progressIndicator: CircularProgressIndicator(
        color: Colors.white,
      ),
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
          title: Text('Product Details'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(''),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'Product ID:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          widget.productId,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Product Description:',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              widget.productDesc = value;
                            },
                            initialValue: productDescriptionController.text,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFE2E3E3),
                              labelStyle: kAddProductTextFieldLableStyle,
                              contentPadding: EdgeInsets.all(10),
                              border: kAddProductTextFieldBorder,
                              focusedBorder: kAddProductTextFieldFocusedBorder,
                              // enabledBorder: kAddProductTextFieldEnabledBorder,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                'Size:',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizesDropdown(
                              iconColor: Colors.white,
                              backgroundColor: kCardColor,
                              controller: sizeController,
                              onPress: (value) {
                                setState(() {
                                  widget.size = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                'Rate:',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 75,
                              child: TextFormField(
                                onChanged: (value) {
                                  widget.rate = value;
                                },
                                initialValue: rateController.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFE2E3E3),
                                  labelStyle: kAddProductTextFieldLableStyle,
                                  contentPadding: EdgeInsets.all(10),
                                  border: kAddProductTextFieldBorder,
                                  focusedBorder:
                                      kAddProductTextFieldFocusedBorder,
                                  // enabledBorder: kAddProductTextFieldEnabledBorder,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Icon(
                                      FontAwesomeIcons.rupeeSign,
                                      // size: 30,
                                      color: kCardColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'SELL',
                                      style: TextStyle(
                                        color: kCardColor,
                                        fontSize: 20,
                                        // fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              color: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              onPressed: () async {
                                setState(() => widget.showLoading = true);
                                await updateProductWithProductID(
                                  context,
                                  widget.productId,
                                  widget.productDesc,
                                  widget.size,
                                  widget.rate,
                                );
                                await getAllProductsDetails();
                                setState(() => widget.showLoading = false);
                                // print(widget.productDesc +
                                //     widget.size +
                                //     widget.rate);
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.check_circle_sharp,
                                      color: kCardColor,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'UPDATE',
                                      style: TextStyle(
                                        color: kCardColor,
                                        fontSize: 20,
                                        // fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              color: Colors.amberAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'ADDED ON : ${widget.productAddDate} ' +
                          widget.productAddMonth.toString().toUpperCase() +
                          '\'${widget.productAddYear}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
