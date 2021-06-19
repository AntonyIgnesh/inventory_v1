import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';
import 'package:inventory_v1/screens/product_details_screen.dart';
import 'package:inventory_v1/controller/firebase_networks.dart';

Widget CardBuilder(BuildContext context, int index) {
  return ProductsCard(
    productId: allProductsList[index]['ProductId'],
    productDesc: allProductsList[index]['ProductDescription'],
    productAddDate: allProductsList[index]['ProductAddDate'],
    productAddMonth: allProductsList[index]['ProductAddMonth'],
    productAddYear: allProductsList[index]['ProductAddYear'],
    size: allProductsList[index]['Size'],
    rate: allProductsList[index]['Rate'],
  );
}

class ProductsCard extends StatefulWidget {
  final String productId;
  final String productDesc;
  final String productAddDate;
  final String productAddMonth;
  final String productAddYear;
  final String size;
  final String rate;

  ProductsCard({
    this.productId,
    this.productDesc,
    this.productAddDate,
    this.productAddMonth,
    this.productAddYear,
    this.size,
    this.rate,
  });

  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  bool showLoading = false;

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Building card');
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Route route = MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            productId: widget.productId,
            productDesc: widget.productDesc,
            productAddDate: widget.productAddDate,
            productAddMonth: widget.productAddMonth,
            productAddYear: widget.productAddYear,
            size: widget.size,
            rate: widget.rate,
          ),
        );
        Navigator.push(context, route).then(onGoBack);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: kCardColor,
        // shadowColor: Colors.black,
        elevation: 6,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 12,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productId,
                    style: kViewProductProductIdTextStyle,
                  ),
                  Text(
                    '${widget.productAddDate} ${widget.productAddMonth}\'${widget.productAddYear}',
                    style: kViewProductDateTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productDesc.length < 40
                        ? widget.productDesc
                        : widget.productDesc.substring(0, 37) + '...',
                    style: kViewProductProductDescTextStyle,
                  ),
                  Text(
                    widget.size,
                    style: kViewProductSizeTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
