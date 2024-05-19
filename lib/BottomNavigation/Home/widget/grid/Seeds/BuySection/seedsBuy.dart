//
// import 'package:farm_easy/BottomNavigation/Home/widget/grid/Seeds/BuySection/seedsProductPage.dart';
// import 'package:farm_easy/BottomNavigation/Home/widget/grid/UniSlider/UniImageSlider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'seedBuyUI.dart';
// import 'getSeeds/seedsHomeProvaider.dart';
//
// // import 'getCropsBuyHome/cropsHomeProvaider.dart';
//
// class SeedsBuy extends StatefulWidget {
//   const SeedsBuy({Key? key}) : super(key: key);
//
//   @override
//   State<SeedsBuy> createState() => _SeedsBuyState();
// }
//
// class _SeedsBuyState extends State<SeedsBuy> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       SeedsProvider seedsProvider =
//           Provider.of<SeedsProvider>(context, listen: false);
//       seedsProvider.fetchSeedsData();
//       print("fatched");
//     });
//   }
//
//   SeedsProvider? seedsProvider;
//   @override
//   Widget build(BuildContext context) {
//     seedsProvider = Provider.of<SeedsProvider>(context);
//
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
//           child: Column(
//             children: seedsProvider!.getSeedBuyList.map((e) {
//               return SeedBuyUI(
//                 e: e,
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:farm_easy/BottomNavigation/Home/widget/grid/Seeds/BuySection/seedBuyUI.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shimmerCard.dart';
import 'getSeeds/seedsHomeProvaider.dart';

class SeedsBuy extends StatelessWidget {
  const SeedsBuy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SeedsProvider>(
      builder: (context, seedsProvider, _) {
        if (seedsProvider.isLoading) {
          return ShimmerEffect(); // Show shimmer effect while data is being fetched
        } else {
          return Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 13.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: seedsProvider.getSeedBuyList.map((e) {
                    return SeedBuyUI(e: e);
                  }).toList(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
