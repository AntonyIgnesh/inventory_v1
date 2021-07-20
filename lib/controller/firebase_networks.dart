import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:inventory_v1/widgets/toast.dart';

final _fireStore = FirebaseFirestore.instance;
List<DropdownMenuItem<String>> sizeListFromFireStore = [];
String finalProductDocumentId;
String finalNewProductId;
String todayDate;
String todayMonth;
String todayYear;
List<Map<String, dynamic>> allProductsList = [];
var sizeFromFireStore;

Future getSizesFromFireBase() async {
  try {
    sizeFromFireStore =
        await _fireStore.collection("productSizes").doc("sizes").get();
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
    if (productDesc.isNotEmpty && (int.parse(rate) != 0)) {
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
      ShowingToast(context: context)
          .showSuccessToast("Product " + productId + " added Successfully");
      Navigator.pop(context);
    } else {
      if (productDesc.isEmpty) {
        ShowingToast(context: context).showFailureToast(
          "Description can\'t be empty",
        );
      } else if (int.parse(rate) == 0) {
        ShowingToast(context: context).showFailureToast(
          "Rate can\'t be 0",
        );
      }
    }
  } catch (e) {
    ShowingToast(context: context).showFailureToast(
      "Error occurred while adding product",
    );
  }
}

Future getAllProductsDetails() async {
  var documentWithAllProductDetails =
      await _fireStore.collection('products').get();
  List<DocumentSnapshot> allProductsListFromFireStore =
      documentWithAllProductDetails.docs;
  if (allProductsListFromFireStore.isNotEmpty) {
    allProductsListFromFireStore.forEach((element) {
      allProductsList.add({
        'ProductId': element.get('ProductId'),
        'ProductDescription': element.get('ProductDescription'),
        'Size': element.get('Size'),
        'Rate': element.get('Rate'),
        'ProductAddDate': element.get('ProductAddDate'),
        'ProductAddMonth': element.get('ProductAddMonth'),
        'ProductAddYear': element.get('ProductAddYear'),
        'Timestamp': element.get('Timestamp'),
      });
    });
    // print('Getting products details');
    // allProductsList.forEach((element) {
    //   print(element);
    // });
  }
}

Future updateProductWithProductID(
  BuildContext context,
  String productId,
  String productDesc,
  String size,
  String rate,
  String addDate,
  String addMonth,
  String addYear,
) async {
  try {
    if (productDesc.isNotEmpty && rate.isNotEmpty && (int.parse(rate) != 0)) {
      await _fireStore
          .collection('products')
          .where(
            "ProductId",
            isEqualTo: productId,
          )
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) async {
                String docId = element.id;
                await _fireStore.collection('products').doc(docId).set(
                  {
                    'ProductId': productId,
                    'ProductDescription': productDesc,
                    'Size': size,
                    'Rate': rate,
                    'ProductAddDate': addDate,
                    'ProductAddMonth': addMonth,
                    'ProductAddYear': addYear,
                    'Timestamp': DateTime.now(),
                  },
                );
                ShowingToast(context: context).showSuccessToast(
                    "Product " + productId + " updated Successfully");
                Navigator.pop(context);
              },
            ),
          );
    } else {
      if (productDesc.isEmpty) {
        ShowingToast(context: context).showFailureToast(
          'Description is Mandatory',
        );
      } else if (rate.isEmpty) {
        ShowingToast(context: context).showFailureToast(
          'Rate is Mandatory',
        );
      } else if (int.parse(rate) == 0) {
        ShowingToast(context: context).showFailureToast(
          'Rate can\'t be 0',
        );
      }
    }
  } catch (e) {
    ShowingToast(context: context).showFailureToast(
      'Error in updating product ' + productId,
    );
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> getFireStoreInstanceStream() {
  var stream;
  try {
    stream = _fireStore.collection('products').snapshots();
  } catch (e) {
    print('Error in getting Firestore Stream');
    stream = null;
  }
  return stream;
}

deleteProductFromFireStoreWithProductId(String productId) async {
  try {
    await _fireStore
        .collection('products')
        .where(
          "ProductId",
          isEqualTo: productId,
        )
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) async {
              String docId = element.id;
              await _fireStore.collection('products').doc(docId).delete();
            },
          ),
        );
  } catch (e) {
    print('Error in deletion of Product');
  }
}
