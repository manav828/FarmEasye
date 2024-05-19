import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Home/widget/grid/Animals/buySection/getAnimalsBuyHome/getAnimalHomeModel.dart';
import '../../Home/widget/grid/Crops/buySection/getCropsBuyHome/getCropsHomeModel.dart';
import '../../Home/widget/grid/Fertilizer/buySection/getFertilizerBuyHome/getFertilizerHomeModel.dart';
import '../../Home/widget/grid/Machinery/BuySection/getMachineBuyHome/getMachineHomeModel.dart';
import '../../Home/widget/grid/Seeds/BuySection/getSeeds/getSeedsModel.dart';

// Future<Map<String, List<dynamic>>> fetchDataForUser(String userId) async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   // Initialize lists for each collection
//   List<BuyAnimalHomeDataModel> animalData = [];
//   List<BuyCropHomeDataModel> cropData = [];
//   List<BuyFertilizerModel> fertilizerData = [];
//   List<BuyMachineHomeDataModel> machineData = [];
//   List<SeedSellModel> seedData = [];
//
//   // Fetch data for each collection
//   await Future.wait([
//     _fetchCollectionData('Animals', userId, firestore, animalData),
//     _fetchCollectionData('Crops', userId, firestore, cropData),
//     _fetchCollectionData('Fertilizer', userId, firestore, fertilizerData),
//     _fetchCollectionData('Machines', userId, firestore, machineData),
//     _fetchCollectionData('Seeds', userId, firestore, seedData),
//   ]);
//
//   // Return the map containing data lists for each collection
//   return {
//     'Animals': animalData,
//     'Crops': cropData,
//     'Fertilizer': fertilizerData,
//     'Machines': machineData,
//     'Seeds': seedData,
//   };
// }
//
// Future<void> _fetchCollectionData(
//   String collectionName,
//   String userId,
//   FirebaseFirestore firestore,
//   List<dynamic> dataList,
// ) async {
//   try {
//     CollectionReference collectionRef = firestore
//         .collection('User Data')
//         .doc(userId)
//         .collection(collectionName);
//
//     QuerySnapshot collectionSnapshot = await collectionRef.get();
//
//     if (!collectionSnapshot.docs.isEmpty) {
//       collectionSnapshot.docs.forEach((doc) {
//         switch (collectionName) {
//           case 'Animals':
//             dataList.add(BuyAnimalHomeDataModel(
//                 // Populate the BuyAnimalHomeDataModel object
//                 ));
//             break;
//           case 'Crops':
//             dataList.add(BuyCropHomeDataModel(
//                 // Populate the BuyCropHomeDataModel object
//                 ));
//             break;
//           case 'Fertilizer':
//             dataList.add(BuyFertilizerModel(
//                 // Populate the BuyFertilizerModel object
//                 ));
//             break;
//           case 'Machines':
//             dataList.add(BuyMachineHomeDataModel(
//                 // Populate the BuyMachineHomeDataModel object
//                 ));
//             break;
//           case 'Seeds':
//             dataList.add(SeedSellModel(
//                 // Populate the SeedSellModel object
//                 ));
//             break;
//         }
//       });
//     }
//   } catch (e) {
//     print('Error fetching $collectionName data: $e');
//     // Handle error
//   }
// }

import 'package:flutter/material.dart';

// Define your model classes here

class UserDataProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Map<String, List<dynamic>> userData = {
  //   'Animals': [],
  //   'Crops': [],
  //   'Fertilizer': [],
  //   'Machines': [],
  //   'Seeds': [],
  // };
  List<BuyAnimalHomeDataModel> animalData = [];
  List<BuyCropHomeDataModel> cropData = [];
  List<BuyFertilizerModel> fertilizerData = [];
  List<BuyMachineHomeDataModel> machineData = [];
  List<SeedSellModel> seedData = [];

  Future<void> fetchDataForUser(String userId) async {
    print("call");
    try {
      await Future.wait([
        _fetchCollectionData('Animal', userId),
        _fetchCollectionData('Crops', userId),
        _fetchCollectionData('Fertilier', userId),
        _fetchCollectionData('Machines', userId),
        _fetchCollectionData('Seeds', userId),
      ]);
      notifyListeners();
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _fetchCollectionData(
      String collectionName, String userId) async {
    print("call");

    try {
      QuerySnapshot collectionSnapshot = await _firestore
          .collection('User Data')
          .doc('YLYTDx6HfhTGQMUkVDJ2dkVlSRi2')
          .collection(collectionName)
          .get();

      List<BuyCropHomeDataModel> cropDataList = [];
      List<BuyAnimalHomeDataModel> animalDataList = [];
      List<BuyFertilizerModel> fertiDataList = [];
      List<BuyMachineHomeDataModel> machineDataList = [];
      List<SeedSellModel> seedDataList = [];

      collectionSnapshot.docs.forEach((e) {
        switch (collectionName) {
          case 'Animal':
            List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
                .map((e) => e.toString())
                .toList();
            // print(e.get('animalType'));

            animalDataList.add(BuyAnimalHomeDataModel(
                id: e.id,
                ownerPhone: e.get('ownerPhone'),
                address: e.get('address'),
                description: e.get('description'),
                AnimalType: e.get('animalType'),
                AnimalBreed: e.get('animalBreed'),
                ownerName: e.get('ownerName'),
                state: e.get('state'),
                animalAge: e.get('animalAge'),
                city: e.get('city'),
                price: e.get('animalPrice'),
                imageUrls: imageUrlList));

            break;
          case 'Crops':
            List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
                .map((e) => e.toString())
                .toList();
            print(e.get('cropName'));

            cropDataList.add(BuyCropHomeDataModel(
                id: e.id,
                ownerPhone: e.get('phone'),
                address: e.get('address'),
                description: e.get('description'),
                cropName: e.get('cropName'),
                ownerName: e.get('ownerName'),
                state: e.get('state'),
                city: e.get('city'),
                pricePerQue: e.get('pricePerQue'),
                totalQuintal: e.get('totalQuintal'),
                imageUrls: imageUrlList));

            break;
          case 'Fertilier':
            List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
                .map((e) => e.toString())
                .toList();
            // print(e.get('FertilizerName'));

            fertiDataList.add(
              BuyFertilizerModel(
                  id: e.id,
                  address: e.get('address'),
                  description: e.get('description'),
                  shopName: e.get('shopName'),
                  ownerPhone: e.get('ownerPhone'),
                  ownerName: e.get('ownerName'),
                  weightInKG: e.get('weightInKG'),
                  FertilizerCompany: e.get('FertilizerCompany'),
                  FertilizerName: e.get('FertilizerName'),
                  state: e.get('state'),
                  city: e.get('city'),
                  price: e.get('Price'),
                  imageUrls: imageUrlList),
            );

            break;
          case 'Machines':
            // print("machine hiiiiiii");
            List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
                .map((e) => e.toString())
                .toList();
            // print(e.get('machineName'));

            machineDataList.add(
              BuyMachineHomeDataModel(
                  id: e.id,
                  ownerPhone: e.get('ownerPhone'),
                  address: e.get('address'),
                  description: e.get('description'),
                  machineName: e.get('machineName'),
                  vahicalCompany: e.get('vahicalCompany'),
                  vahicalModel: e.get('vahicalModel'),
                  purchaseYear: e.get('purchaseYear'),
                  ownerName: e.get('ownerName'),
                  state: e.get('state'),
                  city: e.get('city'),
                  kmUsed: e.get('kmUsed'),
                  price: e.get('price'),
                  imageUrls: imageUrlList),
            );

            break;
          case 'Seeds':
            List<String> imageUrlList = (e.get('imageUrls') as List<dynamic>)
                .map((e) => e.toString())
                .toList();
            // print(e.get('seedName'));
            seedDataList.add(
              SeedSellModel(
                  id: e.id,
                  ownerPhone: e.get('ownerPhone'),
                  address: e.get('address'),
                  // description: e.get('description'),
                  seedName: e.get('seedName'),
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
                  requiredPHofWater: e.get('requiredPHofWater')),
            );

            break;
        }
      });

      switch (collectionName) {
        case 'Animal':
          animalData = animalDataList;
          break;
        case 'Crops':
          cropData = cropDataList;
          break;
        case 'Fertilier':
          fertilizerData = fertiDataList;
          break;
        case 'Seeds':
          seedData = seedDataList;
          break;
        case 'Machines':
          machineData = machineDataList;
          break;
      }

      // userData[collectionName] = dataList;
    } catch (e) {
      print('Error fetching $collectionName data: $e');
    }
  }

  List<BuyAnimalHomeDataModel> get getAnimalHomeBuyList {
    // print(animalsHomeList);
    return animalData;
  }

  List<BuyCropHomeDataModel> get getCropList {
    // print(animalsHomeList);
    return cropData;
  }

  List<BuyFertilizerModel> get getfertilizerList {
    // print(animalsHomeList);
    return fertilizerData;
  }

  List<BuyMachineHomeDataModel> get getmachineList {
    // print(animalsHomeList);
    return machineData;
  }

  List<SeedSellModel> get getseedList {
    // print(animalsHomeList);
    return seedData;
  }
}
