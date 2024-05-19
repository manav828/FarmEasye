// import 'package:farm_easy/BottomNavigation/Home/widget/grid/Crops/buySection/cropsProductPage.dart';
// import 'package:farm_easy/BottomNavigation/Home/widget/grid/UniSlider/UniImageSlider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'cropBuyUI.dart';
// import 'getCropsBuyHome/cropsHomeProvaider.dart';
//
// class CropBuy extends StatefulWidget {
//   const CropBuy({Key? key}) : super(key: key);
//
//   @override
//   State<CropBuy> createState() => _CropBuyState();
// }
//
// class _CropBuyState extends State<CropBuy> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       CropProvider cropProvider =
//           Provider.of<CropProvider>(context, listen: false);
//       cropProvider.fetchCropsData();
//     });
//   }
//
//   CropProvider? cropProvider;
//   @override
//   Widget build(BuildContext context) {
//     cropProvider = Provider.of<CropProvider>(context);
//
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
//           child: Column(
//             children: cropProvider!.getCropsHomeBuyList.map((e) {
//               return CropBuyUI(e:e);
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'cropBuyUI.dart';
//
// import 'getCropsBuyHome/cropsHomeProvaider.dart';
// import '../../shimmerCard.dart';
//
// class CropBuy extends StatelessWidget {
//   const CropBuy({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CropProvider>(
//       builder: (context, cropProvider, _) {
//         if (cropProvider.isLoading) {
//           return ShimmerEffect(); // Show shimmer effect while data is being fetched
//         } else {
//           return Container(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 13.0,
//                   horizontal: 20.0,
//                 ),
//                 child: Column(
//                   children: cropProvider.getCropsHomeBuyList.map((e) {
//                     return CropBuyUI(e: e);
//                   }).toList(),
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cropBuyUI.dart';
import 'getCropsBuyHome/cropsHomeProvaider.dart';
import '../../shimmerCard.dart';

class CropBuy extends StatefulWidget {
  const CropBuy({Key? key}) : super(key: key);

  @override
  State<CropBuy> createState() => _CropBuyState();
}

class _CropBuyState extends State<CropBuy> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   CropProvider cropProvider =
    //       Provider.of<CropProvider>(context, listen: false);
    //   cropProvider.fetchMoreCropsData();
    // });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta =
        200.0; // Adjust this value to determine how far from the bottom to trigger loading more data

    if (maxScroll - currentScroll <= delta) {
      // Reached the bottom
      final cropProvider = Provider.of<CropProvider>(context, listen: false);
      if (cropProvider.hasMore && !cropProvider.isLoading) {
        // Fetch more data only if there is more data to fetch and not already loading
        cropProvider.fetchMoreCropsData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CropProvider>(
      builder: (context, cropProvider, _) {
        if (cropProvider.isLoading && cropProvider.cropsHomeList.isEmpty) {
          return ShimmerEffect(); // Show shimmer effect while data is being fetched
        } else {
          return Container(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 13.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: cropProvider.getCropsHomeBuyList.map((e) {
                    return CropBuyUI(e: e);
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
