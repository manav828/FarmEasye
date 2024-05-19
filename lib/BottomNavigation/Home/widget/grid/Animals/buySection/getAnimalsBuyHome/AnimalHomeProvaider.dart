// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'getAnimalHomeModel.dart';
// // import 'getCropsHomeModel.dart';
//
// class AnimalProvider extends ChangeNotifier {
//   bool _isLoading = false; // Add isLoading property
//   late BuyAnimalHomeDataModel animalHomeModel;
//   List<BuyAnimalHomeDataModel> animalsHomeList = [];
//
//   AnimalProvider() {
//     fetchAnimalsData();
//   }
//
//   bool get isLoading => _isLoading; // Getter for isLoading
//
//   Future<void> fetchAnimalsData() async {
//     _isLoading = true; // Set isLoading to true when fetching data
//     notifyListeners();
//
//     List<BuyAnimalHomeDataModel> newList = [];
//     print("Method call");
//     final QuerySnapshot Items =
//         await FirebaseFirestore.instance.collection("Animals").get();
//     print(Items.docs);
//     print("document id ");
//     for (var e in Items.docs) {
//       print(e.get('state'));
//       List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
//           .map((e) => e.toString())
//           .toList();
//       animalHomeModel = BuyAnimalHomeDataModel(
//           id: e.id,
//           ownerPhone: e.get('ownerPhone'),
//           address: e.get('address'),
//           description: e.get('description'),
//           AnimalType: e.get('animalType'),
//           ownerId: e.get('userId'),
//           AnimalBreed: e.get('animalBreed'),
//           ownerName: e.get('ownerName'),
//           state: e.get('state'),
//           animalAge: e.get('animalAge'),
//           city: e.get('city'),
//           price: e.get('animalPrice'),
//           imageUrls: imageUrlList);
//       newList.add(animalHomeModel);
//       ;
//     }
//     animalsHomeList = newList;
//     _isLoading = false; // Set isLoading to true when fetching data
//     // notifyListeners();
//     notifyListeners();
//   }
//
//   List<BuyAnimalHomeDataModel> get getAnimalHomeBuyList {
//     print(animalsHomeList);
//     return animalsHomeList;
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'getAnimalHomeModel.dart';

class AnimalProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasMore = true;
  int _batchSize = 3;
  late BuyAnimalHomeDataModel animalHomeModel;
  List<BuyAnimalHomeDataModel> animalsHomeList = [];

  AnimalProvider() {
    fetchAnimalsData();
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchAnimalsData() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final QuerySnapshot items = await FirebaseFirestore.instance
          .collection("Animals")
          .limit(_batchSize)
          .get();

      if (items.docs.isEmpty) {
        _hasMore = false;
      }

      for (var e in items.docs) {
        List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
            .map((e) => e.toString())
            .toList();
        animalHomeModel = BuyAnimalHomeDataModel(
          id: e.id,
          ownerPhone: e.get('ownerPhone'),
          address: e.get('address'),
          description: e.get('description'),
          AnimalType: e.get('animalType'),
          ownerId: e.get('userId'),
          AnimalBreed: e.get('animalBreed'),
          ownerName: e.get('ownerName'),
          state: e.get('state'),
          animalAge: e.get('animalAge'),
          city: e.get('city'),
          price: e.get('animalPrice'),
          imageUrls: imageUrlList,
        );
        animalsHomeList.add(animalHomeModel);
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreAnimalsData() async {
    if (!_hasMore || _isLoading) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      DocumentSnapshot<Object?>? lastDocument;
      if (animalsHomeList.isNotEmpty) {
        lastDocument = await FirebaseFirestore.instance
            .collection("Animals")
            .doc(animalsHomeList.last.id)
            .get();
      }

      final nextQuery = FirebaseFirestore.instance
          .collection("Animals")
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
          return BuyAnimalHomeDataModel(
            id: e.id,
            ownerPhone: e.get('ownerPhone'),
            address: e.get('address'),
            description: e.get('description'),
            AnimalType: e.get('animalType'),
            ownerId: e.get('userId'),
            AnimalBreed: e.get('animalBreed'),
            ownerName: e.get('ownerName'),
            state: e.get('state'),
            animalAge: e.get('animalAge'),
            city: e.get('city'),
            price: e.get('animalPrice'),
            imageUrls: imageUrlList,
          );
        }).toList();

        animalsHomeList.addAll(newList);
      }
    } catch (error) {
      print('Error fetching more data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<BuyAnimalHomeDataModel> get getAnimalHomeBuyList {
    return animalsHomeList;
  }
}
