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

class ProductsCard extends StatelessWidget {
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

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              productId: productId,
              productDesc: productDesc,
              productAddDate: productAddDate,
              productAddMonth: productAddMonth,
              productAddYear: productAddYear,
              size: size,
              rate: rate,
            ),
          ),
        );
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
                    productId,
                    style: kViewProductProductIdTextStyle,
                  ),
                  Text(
                    '$productAddDate $productAddMonth\'$productAddYear',
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
                    productDesc.length < 40
                        ? productDesc
                        : productDesc.substring(0, 37) + '...',
                    style: kViewProductProductDescTextStyle,
                  ),
                  Text(
                    size,
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
