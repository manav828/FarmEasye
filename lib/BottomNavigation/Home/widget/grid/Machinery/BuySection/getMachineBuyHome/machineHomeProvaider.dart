// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// // import 'getCropsHomeModel.dart';
// import 'getMachineHomeModel.dart';
//
// class MachineProvider extends ChangeNotifier {
//   bool _isLoading = false; // Add isLoading property
//
//   late BuyMachineHomeDataModel buyMachineHomeDataModel;
//   List<BuyMachineHomeDataModel> vahicalsHomeList = [];
//
//   MachineProvider() {
//     fetchMachineData();
//   }
//   bool get isLoading => _isLoading; // Getter for isLoading
//
//   Future<void> fetchMachineData() async {
//     _isLoading = true; // Set isLoading to true when fetching data
//     notifyListeners();
//
//     List<BuyMachineHomeDataModel> newList = [];
//     print("Method call");
//     final QuerySnapshot Items =
//         await FirebaseFirestore.instance.collection("Machines").get();
//     print(Items.docs);
//     print("document id ");
//     for (var e in Items.docs) {
//       print(e.get('state'));
//       List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
//           .map((e) => e.toString())
//           .toList();
//       buyMachineHomeDataModel = BuyMachineHomeDataModel(
//           id: e.id,
//           ownerPhone: e.get('ownerPhone'),
//           address: e.get('address'),
//           description: e.get('description'),
//           machineName: e.get('machineName'),
//           ownerId: e.get('userId'),
//           vahicalCompany: e.get('vahicalCompany'),
//           vahicalModel: e.get('vahicalModel'),
//           purchaseYear: e.get('purchaseYear'),
//           ownerName: e.get('ownerName'),
//           state: e.get('state'),
//           city: e.get('city'),
//           kmUsed: e.get('kmUsed'),
//           price: e.get('price'),
//           imageUrls: imageUrlList);
//       newList.add(buyMachineHomeDataModel);
//       ;
//     }
//     vahicalsHomeList = newList;
//     _isLoading = false; // Set isLoading to true when fetching data
//
//     notifyListeners();
//   }
//
//   List<BuyMachineHomeDataModel> get getMachineHomeBuyList {
//     print(vahicalsHomeList);
//     return vahicalsHomeList;
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'getMachineHomeModel.dart';

class MachineProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasMore = true;
  int _batchSize = 3;
  late BuyMachineHomeDataModel machineHomeModel;
  List<BuyMachineHomeDataModel> machineHomeList = [];

  MachineProvider() {
    fetchMachineData();
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchMachineData() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final QuerySnapshot items = await FirebaseFirestore.instance
          .collection("Machines")
          .limit(_batchSize)
          .get();

      if (items.docs.isEmpty) {
        _hasMore = false;
      }

      for (var e in items.docs) {
        List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
            .map((e) => e.toString())
            .toList();
        machineHomeModel = BuyMachineHomeDataModel(
          id: e.id,
          ownerPhone: e.get('ownerPhone'),
          address: e.get('address'),
          description: e.get('description'),
          machineName: e.get('machineName'),
          ownerId: e.get('userId'),
          vahicalCompany: e.get('vahicalCompany'),
          vahicalModel: e.get('vahicalModel'),
          purchaseYear: e.get('purchaseYear'),
          ownerName: e.get('ownerName'),
          state: e.get('state'),
          city: e.get('city'),
          kmUsed: e.get('kmUsed'),
          price: e.get('price'),
          imageUrls: imageUrlList,
        );
        machineHomeList.add(machineHomeModel);
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreMachineData() async {
    if (!_hasMore || _isLoading) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // final lastDocument = machineHomeList.last;
      DocumentSnapshot<Object?>? lastDocument;
      if (machineHomeList.isNotEmpty) {
        lastDocument = await FirebaseFirestore.instance
            .collection("Machines")
            .doc(machineHomeList.last.id)
            .get();
      }
      final nextQuery = FirebaseFirestore.instance
          .collection("Machines")
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
          return BuyMachineHomeDataModel(
            id: e.id,
            ownerPhone: e.get('ownerPhone'),
            address: e.get('address'),
            description: e.get('description'),
            machineName: e.get('machineName'),
            ownerId: e.get('userId'),
            vahicalCompany: e.get('vahicalCompany'),
            vahicalModel: e.get('vahicalModel'),
            purchaseYear: e.get('purchaseYear'),
            ownerName: e.get('ownerName'),
            state: e.get('state'),
            city: e.get('city'),
            kmUsed: e.get('kmUsed'),
            price: e.get('price'),
            imageUrls: imageUrlList,
          );
        }).toList();

        machineHomeList.addAll(newList);
      }
    } catch (error) {
      print('Error fetching more data: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<BuyMachineHomeDataModel> get getMachineHomeBuyList {
    return machineHomeList;
  }
}
