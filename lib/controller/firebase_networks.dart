import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:inventory_v1/constants.dart';
import 'package:inventory_v1/widgets/toast.dart';

final _fireStore = FirebaseFirestore.instance;
List<DropdownMenuItem<String>> sizeListFromFireStore = [];
String finalProductDocumentId;
String finalNewProductId;
String todayDate;
String todayMonth;
String todayYear;

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

  var documentsFromFireStore = await _fireStore.collection("products").get();

  if (documentsFromFireStore != null) {
    documents = documentsFromFireStore.docs;
    if (documents.isNotEmpty) {
      documents.forEach((data) {
        productDocumentIdList.add(data.id);
      });
      productDocumentIdList.sort();
      print(productDocumentIdList);
      lastAddedProductDocumentId =
          int.parse(productDocumentIdList.last.substring(7));
      newProductDocumentId = lastAddedProductDocumentId + 1;

      finalProductDocumentId =
          'Product${newProductDocumentId.toString().padLeft(10, '0')}';
    } else {
      finalProductDocumentId = 'Product0000000001';
    }
  }

  print(finalProductDocumentId);
}

Future generateProductID() async {
  List<String> productIdFromFireStore = [];
  DateTime dateUnformatted = DateTime.now();
  DateFormat dateFormatted = DateFormat('dd MMM yy');
  String fullDateNeeded = dateFormatted.format(dateUnformatted);

  var splitDate = fullDateNeeded.split(' ');
  todayDate = splitDate[0];
  todayMonth = splitDate[1];
  todayYear = splitDate[2];

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

      productIdFromFireStore.sort();
      String lastAddedProductId = productIdFromFireStore.last;
      String lastAddedProductIdNumbersOnly = lastAddedProductId.substring(6);
      int lastAddedProductIdNumbersOnlyInt =
          int.parse(lastAddedProductIdNumbersOnly);
      int newProductIdInt = lastAddedProductIdNumbersOnlyInt + 1;
      finalNewProductId = todayMonth.toUpperCase() +
          todayYear +
          '-' +
          newProductIdInt.toString().padLeft(5, '0');
    } else {
      finalNewProductId = todayMonth.toUpperCase() + todayYear + '-00001';
    }
    print(finalNewProductId);
  }
}

Future addProduct(BuildContext context, String productId, String productDesc,
    String size, String rate) async {
  try {
    if (productDesc.isNotEmpty) {
      // setState(() => showLoading = true);
      await _fireStore.collection('products').doc(finalProductDocumentId).set(
        {
          'ProductId': productId,
          'ProductDescription': productDesc,
          'Size': size,
          'Rate': rate,
          'ProductAddDate': todayDate,
          'ProductAddMonth': todayMonth,
          'ProductAddYear': todayYear,
          'Timestamp': DateTime.now(),
        },
      );
      // setState(() => showLoading = false);
      ShowingToast(context: context)
          .showSuccessToast("Product " + productId + " added Successfully");
      Navigator.pop(context);
    } else if (productDesc.isEmpty) {
      ShowingToast(context: context).showFailureToast(
        "Description can\'t be empty",
      );
    }
  } catch (e) {
    ShowingToast(context: context).showFailureToast(
      "Error occurred while adding product",
    );
  }
}