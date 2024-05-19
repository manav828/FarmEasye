// import 'package:farm_easy/BottomNavigation/Home/widget/grid/UniSlider/UniImageSlider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'fertilizerBuyUI.dart';
// import 'fertilizerProductPage.dart';
// import 'getFertilizerBuyHome/FertilizerHomeProvaider.dart';
//
// // import 'getAnimalsBuyHome/AnimalHomeProvaider.dart';
//
// class FertilizerBuy extends StatefulWidget {
//   const FertilizerBuy({Key? key}) : super(key: key);
//
//   @override
//   State<FertilizerBuy> createState() => _FertilizerBuyState();
// }
//
// class _FertilizerBuyState extends State<FertilizerBuy> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       FertilizerProvider fertilizerProvider =
//           Provider.of<FertilizerProvider>(context, listen: false);
//       fertilizerProvider.fetchFeertilizerData();
//     });
//   }
//
//   FertilizerProvider? fertilizerProvider;
//   @override
//   Widget build(BuildContext context) {
//     fertilizerProvider = Provider.of<FertilizerProvider>(context);
//
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
//           child: Column(
//             children: fertilizerProvider!.getFertiliHomeBuyList.map((e) {
//               return FertilizerBuyUI(e:e);
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fertilizerBuyUI.dart';
import 'getFertilizerBuyHome/FertilizerHomeProvaider.dart';
import '../../shimmerCard.dart';

class FertilizerBuy extends StatefulWidget {
  const FertilizerBuy({Key? key}) : super(key: key);

  @override
  State<FertilizerBuy> createState() => _FertilizerBuyState();
}

class _FertilizerBuyState extends State<FertilizerBuy> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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
    final delta = 200.0;

    if (maxScroll - currentScroll <= delta) {
      final fertilizerProvider =
          Provider.of<FertilizerProvider>(context, listen: false);
      if (fertilizerProvider.hasMore && !fertilizerProvider.isLoading) {
        fertilizerProvider.fetchMoreFertilizerData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FertilizerProvider>(
      builder: (context, fertilizerProvider, _) {
        if (fertilizerProvider.isLoading &&
            fertilizerProvider.fertilizerHomeList.isEmpty) {
          return ShimmerEffect();
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
                  children:
                      fertilizerProvider.getFertilizerHomeBuyList.map((e) {
                    return FertilizerBuyUI(e: e);
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
