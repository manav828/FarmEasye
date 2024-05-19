// import 'package:farm_easy/BottomNavigation/Home/widget/grid/UniSlider/UniImageSlider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'getMachineBuyHome/machineHomeProvaider.dart';
// import 'machineBuyUI.dart';
// import 'machineProductPage.dart';
//
// // import 'getCropsBuyHome/cropsHomeProvaider.dart';
//
// class MachineBuy extends StatefulWidget {
//   const MachineBuy({Key? key}) : super(key: key);
//
//   @override
//   State<MachineBuy> createState() => _MachineBuyState();
// }
//
// class _MachineBuyState extends State<MachineBuy> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       MachineProvider machineProvider =
//           Provider.of<MachineProvider>(context, listen: false);
//       machineProvider.fetchMachineData();
//     });
//   }
//
//   MachineProvider? machineProvider;
//   @override
//   Widget build(BuildContext context) {
//     machineProvider = Provider.of<MachineProvider>(context);
//
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
//           child: Column(
//             children: machineProvider!.getMachineHomeBuyList.map((e) {
//               return MachineBuyUI(e: e);
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shimmerCard.dart';
import 'getMachineBuyHome/machineHomeProvaider.dart';
import 'machineBuyUI.dart';

class MachineBuy extends StatelessWidget {
  const MachineBuy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MachineProvider>(
      builder: (context, machineProvider, _) {
        if (machineProvider.isLoading) {
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
                  children: machineProvider.getMachineHomeBuyList.map((e) {
                    return MachineBuyUI(e: e);
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
