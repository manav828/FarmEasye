import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_easy/BottomNavigation/Home/widget/grid/Animals/buySection/animalBuyUI.dart';
import 'package:farm_easy/BottomNavigation/Home/widget/grid/Crops/buySection/cropBuyUI.dart';
import 'package:farm_easy/BottomNavigation/Home/widget/grid/Fertilizer/buySection/fertilizerBuyUI.dart';
import 'package:farm_easy/BottomNavigation/Home/widget/grid/Machinery/BuySection/machineBuyUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../user_onbording/user_provaider.dart';
import '../Home/widget/grid/Seeds/BuySection/getSeeds/getSeedsModel.dart';
import '../Home/widget/grid/Seeds/BuySection/seedBuyUI.dart';
import '../Home/widget/grid/shimmerCard.dart';
import 'getListedProduct/getProfileData.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.30,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/mask.png'),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 90,
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20),
//                           child: Text(
//                             "User Profile",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         CircleAvatar(
//                           radius: 70,
//                           backgroundImage: AssetImage(
//                             'assets/abc.jpg',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void initState() {
    super.initState();
    _fetch();

    // Call fetchDataForUser method when the widget is initialized
    Provider.of<UserDataProvider>(context, listen: false)
        .fetchDataForUser('YLYTDx6HfhTGQMUkVDJ2dkVlSRi2');
  }

  String UserName = '';
  String imageLink = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('User Data')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          UserName = ds.get('UserName');
          imageLink = ds.get('ImageUrl');
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/mask.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            UserName != null ? UserName : "Profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            imageLink,
                          ),
                        ),
                        // Display user data fetched from Firebase
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer<UserDataProvider>(
              builder: (context, userDataProvider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCollectionSection(
                      title: 'Seed',
                      dataList: userDataProvider.seedData,
                      itemBuilder: (e) => SeedBuyUI(e: e),
                    ),
                    _buildCollectionSection(
                      title: 'Crop',
                      dataList: userDataProvider.cropData,
                      itemBuilder: (e) => CropBuyUI(e: e),
                    ),
                    _buildCollectionSection(
                      title: 'Machine',
                      dataList: userDataProvider.machineData,
                      itemBuilder: (e) => MachineBuyUI(e: e),
                    ),
                    _buildCollectionSection(
                      title: 'Fertilizer',
                      dataList: userDataProvider.fertilizerData,
                      itemBuilder: (e) => FertilizerBuyUI(e: e),
                    ),
                    _buildCollectionSection(
                      title: 'Animal',
                      dataList: userDataProvider.animalData,
                      itemBuilder: (e) => AnimalBuyUI(e: e),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionSection<T>({
    required String title,
    required List<T> dataList,
    required Widget Function(T) itemBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title Section",
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 10),
          dataList.isEmpty
              ? ShimmerEffect() // Use existing ShimmerEffect here
              : Column(
                  children: dataList.map((e) {
                    return itemBuilder(e);
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
