// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'getFertilizerHomeModel.dart';
//
// class FertilizerProvider extends ChangeNotifier {
//   bool _isLoading = false; // Add isLoading property
//
//   late BuyFertilizerModel buyFertilizerModel;
//   List<BuyFertilizerModel> FretilizerHomeList = [];
//
//   FertilizerProvider() {
//     fetchFeertilizerData();
//   }
//   bool get isLoading => _isLoading; // Getter for isLoading
//
//   Future<void> fetchFeertilizerData() async {
//     _isLoading = true; // Set isLoading to true when fetching data
//     notifyListeners();
//
//     List<BuyFertilizerModel> newList = [];
//     print("Method call");
//     final QuerySnapshot Items =
//         await FirebaseFirestore.instance.collection("Fertilier").get();
//     print(Items.docs);
//     print("document id ");
//     for (var e in Items.docs) {
//       print(e.get('state'));
//       List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
//           .map((e) => e.toString())
//           .toList();
//       buyFertilizerModel = BuyFertilizerModel(
//           id: e.id,
//           ownerPhone: e.get('ownerPhone'),
//           address: e.get('address'),
//           description: e.get('description'),
//           ownerId: e.get('userId'),
//           ownerName: e.get('ownerName'),
//           shopName: e.get('shopName'),
//           weightInKG: e.get('weightInKG'),
//           FertilizerCompany: e.get('FertilizerCompany'),
//           FertilizerName: e.get('FertilizerName'),
//           state: e.get('state'),
//           city: e.get('city'),
//           price: e.get('Price'),
//           imageUrls: imageUrlList);
//       newList.add(buyFertilizerModel);
//       ;
//     }
//     FretilizerHomeList = newList;
//     _isLoading = false; // Set isLoading to true when fetching data
//
//     notifyListeners();
//   }
//
//   List<BuyFertilizerModel> get getFertiliHomeBuyList {
//     print(FretilizerHomeList);
//     return FretilizerHomeList;
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'getFertilizerHomeModel.dart';

class FertilizerProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasMore = true;
  int _batchSize = 3;
  late BuyFertilizerModel buyFertilizerModel;
  List<BuyFertilizerModel> fertilizerHomeList = [];

  FertilizerProvider() {
    fetchFertilizerData();
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchFertilizerData() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final QuerySnapshot items = await FirebaseFirestore.instance
          .collection("Fertilier")
          .limit(_batchSize)
          .get();

      if (items.docs.isEmpty) {
        _hasMore = false;
      }

      for (var e in items.docs) {
        List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
            .map((e) => e.toString())
            .toList();
        buyFertilizerModel = BuyFertilizerModel(
          id: e.id,
          ownerPhone: e.get('ownerPhone'),
          address: e.get('address'),
          description: e.get('description'),
          ownerId: e.get('userId'),
          ownerName: e.get('ownerName'),
          shopName: e.get('shopName'),
          weightInKG: e.get('weightInKG'),
          FertilizerCompany: e.get('FertilizerCompany'),
          FertilizerName: e.get('FertilizerName'),
          state: e.get('state'),
          city: e.get('city'),
          price: e.get('Price'),
          imageUrls: imageUrlList,
        );
        fertilizerHomeList.add(buyFertilizerModel);
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreFertilizerData() async {
    if (!_hasMore || _isLoading) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      DocumentSnapshot<Object?>? lastDocument;
      if (fertilizerHomeList.isNotEmpty) {
        lastDocument = await FirebaseFirestore.instance
            .collection("Fertilier")
            .doc(fertilizerHomeList.last.id)
            .get();
      }

      final nextQuery = FirebaseFirestore.instance
          .collection("Fertilier")
          .startAfterDocument(lastDocument!)
          .limit(_batchSize);

      final nextSnapshot = await nextQuery.get();

      if (nextSnapshot.docs.isEmpty) {
        _hasMore = false;
      } else {
        final newList = nextSnapshot.docs.map((e) {
          List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
              .map((e) => e.toString())
              .toList();
          return BuyFertilizerModel(
            id: e.id,
            ownerPhone: e.get('ownerPhone'),
            address: e.get('address'),
            description: e.get('description'),
            ownerId: e.get('userId'),
            ownerName: e.get('ownerName'),
            shopName: e.get('shopName'),
            weightInKG: e.get('weightInKG'),
            FertilizerCompany: e.get('FertilizerCompany'),
            FertilizerName: e.get('FertilizerName'),
            state: e.get('state'),
            city: e.get('city'),
            price: e.get('Price'),
            imageUrls: imageUrlList,
          );
        }).toList();

        fertilizerHomeList.addAll(newList);
      }
    } catch (error) {
      print('Error fetching more data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<BuyFertilizerModel> get getFertilizerHomeBuyList {
    return fertilizerHomeList;
  }
}
