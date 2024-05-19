// // import 'package:farm_easy/BottomNavigation/Home/widget/grid/UniSlider/UniImageSlider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// //
// // import 'animalBuyUI.dart';
// // import 'animalProductPage.dart';
// // import 'getAnimalsBuyHome/AnimalHomeProvaider.dart';
// //
// // class AnimalsBuy extends StatefulWidget {
// //   const AnimalsBuy({Key? key}) : super(key: key);
// //
// //   @override
// //   State<AnimalsBuy> createState() => _AnimalsBuyState();
// // }
// //
// // class _AnimalsBuyState extends State<AnimalsBuy> {
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //       AnimalProvider animalProvider =
// //           Provider.of<AnimalProvider>(context, listen: false);
// //       animalProvider.fetchCropsData();
// //     });
// //   }
// //
// //   AnimalProvider? animalProvider;
// //   @override
// //   Widget build(BuildContext context) {
// //     animalProvider = Provider.of<AnimalProvider>(context);
// //
// //     return Container(
// //       child: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
// //           child: Column(
// //             children: animalProvider!.getAnimalHomeBuyList.map((e) {
// //               return AnimalBuyUI(e: e);
// //             }).toList(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'animalBuyUI.dart';
// import 'getAnimalsBuyHome/AnimalHomeProvaider.dart';
// import '../../shimmerCard.dart';
//
// class AnimalsBuy extends StatelessWidget {
//   const AnimalsBuy({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AnimalProvider>(
//       builder: (context, animalProvider, _) {
//         if (animalProvider.isLoading) {
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
//                   children: animalProvider.animalsHomeList.map((e) {
//                     return AnimalBuyUI(e: e);
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
import 'animalBuyUI.dart';
import 'getAnimalsBuyHome/AnimalHomeProvaider.dart';
import '../../shimmerCard.dart';

class AnimalsBuy extends StatefulWidget {
  const AnimalsBuy({Key? key}) : super(key: key);

  @override
  State<AnimalsBuy> createState() => _AnimalsBuyState();
}

class _AnimalsBuyState extends State<AnimalsBuy> {
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
      final animalProvider =
          Provider.of<AnimalProvider>(context, listen: false);
      if (animalProvider.hasMore && !animalProvider.isLoading) {
        animalProvider.fetchMoreAnimalsData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalProvider>(
      builder: (context, animalProvider, _) {
        if (animalProvider.isLoading &&
            animalProvider.animalsHomeList.isEmpty) {
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
                  children: animalProvider.getAnimalHomeBuyList.map((e) {
                    return AnimalBuyUI(e: e);
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
