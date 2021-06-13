import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';

class TotalAssetScreen extends StatelessWidget {
  double totalAssetValue = 999999999.9999;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total Asset worth',
                style: kFunctionTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'INR ' + totalAssetValue.toString(),
                style: kAssetAmountTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
