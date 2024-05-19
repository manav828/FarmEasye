// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'getCropsHomeModel.dart';
//
// class CropProvider extends ChangeNotifier {
//   bool _isLoading = false; // Add isLoading property
//
//   late BuyCropHomeDataModel cropsHomeModel;
//   List<BuyCropHomeDataModel> cropsHomeList = [];
//   CropProvider() {
//     // Fetch crops data when CropProvider is initialized
//     fetchCropsData();
//   }
//   bool get isLoading => _isLoading; // Getter for isLoading
//
//   Future<void> fetchCropsData() async {
//     _isLoading = true; // Set isLoading to true when fetching data
//     notifyListeners();
//
//     List<BuyCropHomeDataModel> newList = [];
//     print("Method call");
//     final QuerySnapshot Items =
//         await FirebaseFirestore.instance.collection("Crops").get();
//     print(Items.docs);
//     print("document id ");
//     for (var e in Items.docs) {
//       print(e.get('state'));
//       List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
//           .map((e) => e.toString())
//           .toList();
//       cropsHomeModel = BuyCropHomeDataModel(
//           id: e.id,
//           ownerPhone: e.get('ownerPhone'),
//           address: e.get('address'),
//           description: e.get('description'),
//           cropName: e.get('cropName'),
//           ownerId: e.get('userId'),
//           ownerName: e.get('ownerName'),
//           state: e.get('state'),
//           city: e.get('city'),
//           pricePerQue: e.get('pricePerQue'),
//           totalQuintal: e.get('totalQuintal'),
//           imageUrls: imageUrlList);
//       newList.add(cropsHomeModel);
//       ;
//     }
//     cropsHomeList = newList;
//     _isLoading = false; // Set isLoading to true when fetching data
//
//     notifyListeners();
//   }
//
//   List<BuyCropHomeDataModel> get getCropsHomeBuyList {
//     print(cropsHomeList);
//     return cropsHomeList;
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'getCropsHomeModel.dart';

class CropProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasMore = true;
  int _batchSize = 3;
  late BuyCropHomeDataModel cropsHomeModel;
  List<BuyCropHomeDataModel> cropsHomeList = [];

  CropProvider() {
    fetchCropsData();
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchCropsData() async {
    print("fatch fetchCropsData data");
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final QuerySnapshot items = await FirebaseFirestore.instance
          .collection("Crops")
          .limit(_batchSize)
          .get();

      if (items.docs.isEmpty) {
        _hasMore = false;
      }

      for (var e in items.docs) {
        List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
            .map((e) => e.toString())
            .toList();
        cropsHomeModel = BuyCropHomeDataModel(
          id: e.id,
          ownerPhone: e.get('ownerPhone'),
          address: e.get('address'),
          description: e.get('description'),
          cropName: e.get('cropName'),
          ownerId: e.get('userId'),
          ownerName: e.get('ownerName'),
          state: e.get('state'),
          city: e.get('city'),
          pricePerQue: e.get('pricePerQue'),
          totalQuintal: e.get('totalQuintal'),
          imageUrls: imageUrlList,
        );
        cropsHomeList.add(cropsHomeModel);
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreCropsData() async {
    print("Fetching more data");
    if (!_hasMore || _isLoading) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Get the last document from Firestore
      DocumentSnapshot<Object?>? lastDocument;
      if (cropsHomeList.isNotEmpty) {
        lastDocument = await FirebaseFirestore.instance
            .collection("Crops")
            .doc(cropsHomeList.last.id)
            .get();
      }

      final nextQuery = FirebaseFirestore.instance
          .collection("Crops")
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
          return BuyCropHomeDataModel(
            id: e.id,
            ownerPhone: e.get('ownerPhone'),
            address: e.get('address'),
            description: e.get('description'),
            cropName: e.get('cropName'),
            ownerId: e.get('userId'),
            ownerName: e.get('ownerName'),
            state: e.get('state'),
            city: e.get('city'),
            pricePerQue: e.get('pricePerQue'),
            totalQuintal: e.get('totalQuintal'),
            imageUrls: imageUrlList,
          );
        }).toList();

        cropsHomeList.addAll(newList);
      }
    } catch (error) {
      print('Error fetching more data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<BuyCropHomeDataModel> get getCropsHomeBuyList {
    return cropsHomeList;
  }
}
