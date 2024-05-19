import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'getSeedsModel.dart';

class SeedsProvider extends ChangeNotifier {
  bool _isLoading = false; // Add isLoading property

  late SeedSellModel seedSellModel;
  List<SeedSellModel> seedsList = [];

  SeedsProvider() {
    fetchSeedsData();
  }
  bool get isLoading => _isLoading; // Getter for isLoading

  Future<void> fetchSeedsData() async {
    _isLoading = true; // Set isLoading to true when fetching data
    notifyListeners();

    List<SeedSellModel> newList = [];
    print("Method call");
    final QuerySnapshot Items =
        await FirebaseFirestore.instance.collection("Seeds").get();
    print(Items.docs);
    print("document id ");
    for (var e in Items.docs) {
      print(e.get('state'));
      List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      seedSellModel = SeedSellModel(
          id: e.id,
          ownerPhone: e.get('ownerPhone'),
          address: e.get('address'),
          // description: e.get('description'),
          seedName: e.get('seedName'),
          ownerId: e.get('userId'),
          seedType: e.get('seedType'),
          weight: e.get('weight'),
          variety: e.get('variety'),
          CompanyName: e.get('CompanyName'),
          ownerName: e.get('ownerName'),
          state: e.get('state'),
          city: e.get('city'),
          expectedYield: e.get('expectedYield'),
          price: e.get('price'),
          imageUrls: imageUrlList,
          plantingSeason: e.get('plantingSeason'),
          // requiredSoilCondition: e.get('requiredSoilCondition'),
          requiredPHofWater: e.get('requiredPHofWater'));
      newList.add(seedSellModel);
    }
    seedsList = newList;
    _isLoading = false; // Set isLoading to true when fetching data

    notifyListeners();
  }

  List<SeedSellModel> get getSeedBuyList {
    print(seedsList);
    return seedsList;
  }
}
