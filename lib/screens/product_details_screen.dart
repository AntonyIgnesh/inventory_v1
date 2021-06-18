import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_v1/widgets/sizes_dropdown.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  final String productDesc;
  final String productAddDate;
  final String productAddMonth;
  final String productAddYear;
  String size;
  final String rate;

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
    return Scaffold(
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
                  Container(
                    child: Column(
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
                            productDescriptionController.text = value;
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
                                rateController.text = value;
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
                  FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.amberAccent,
                    child: Icon(
                      Icons.check,
                      size: 35,
                      color: kCardColor,
                    ),
                    onPressed: () {},
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
    );
  }
}
