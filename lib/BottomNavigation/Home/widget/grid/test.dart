import 'package:farm_easy/BottomNavigation/Home/widget/grid/Crops/sellSection/cropSell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Animals/buySection/animalBuy.dart';
import 'Animals/sellSection/animalSell.dart';
import 'Crops/buySection/cropBuy.dart';
import 'Fertilizer/buySection/fertilizerBuy.dart';
import 'Fertilizer/sellSection/fertilizerSell.dart';
import 'Machinery/BuySection/machineBuy.dart';
import 'Machinery/sellSection/machineSell.dart';
import 'Seeds/BuySection/seedsBuy.dart';
import 'Seeds/sellSection/seedsSell.dart';

class Test extends StatefulWidget {
  Test({required this.st});
  String st;
  @override
  _TestState createState() => _TestState();
}

const double width = 300.0;
const double height = 60.0;
const double todayAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.black;
const Color normalColor = Colors.black38;

class _TestState extends State<Test> {
  late double xAlign;
  late Color todayColor;
  late Color tomorrowColor;
  late bool selectedValue;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    xAlign = todayAlign;
    todayColor = selectedColor;
    tomorrowColor = normalColor;
    selectedValue = true;
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget getBuySection() {
    switch (widget.st) {
      case "crops":
        return CropBuy();
      case "machine":
        return MachineBuy();
      case "Fertilizer":
        return FertilizerBuy();
      case "animal":
        return AnimalsBuy();
      case "seeds":
        return SeedsBuy();
      default:
        return Container(); // Return an empty container or handle the case based on your requirements
    }
  }

  Widget getSellSection() {
    switch (widget.st) {
      case "crops":
        return SellSection();
      case "machine":
        return MachineSellSection();
      case "Fertilizer":
        return FertilizerSellSection();
      case "animal":
        return AnimalSellSection();
      case "seeds":
        return SeedsSellSection();
      default:
        return Container(); // Return an empty container or handle the case based on your requirements
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text(widget.st)),
      // ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              // color: Color.fromRGBO(130, 194, 101, 1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_sharp,
                            size: 30,
                          ),
                        ),
                        Text(
                          widget.st,
                          style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width,
                    height: 60,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              xAlign = todayAlign;
                              todayColor = Colors.green;
                              tomorrowColor = normalColor;
                              selectedValue = true;
                              pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            });
                          },
                          child: Align(
                            alignment: Alignment(-1, 0),
                            child: Container(
                              width: width * 0.5,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                "BUY",
                                style: TextStyle(
                                  color: todayColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: VerticalDivider(
                            color: Colors.grey[300],
                            thickness: 4,
                            width: 2,
                            endIndent: 10,
                            indent: 10,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              xAlign = signInAlign;
                              tomorrowColor = Colors.green;
                              selectedValue = false;
                              todayColor = normalColor;
                              pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            });
                          },
                          child: Align(
                            alignment: Alignment(1, 0),
                            child: Container(
                              width: width * 0.5,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                "SELL",
                                style: TextStyle(
                                  color: tomorrowColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedAlign(
                          alignment: Alignment(xAlign, 1),
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            width: width * 0.5,
                            height: 5,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   width: width,
            //   height: 60,
            //   child: Stack(
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             xAlign = todayAlign;
            //             todayColor = Colors.green;
            //             tomorrowColor = normalColor;
            //             selectedValue = true;
            //             pageController.animateToPage(0,
            //                 duration: Duration(milliseconds: 300),
            //                 curve: Curves.ease);
            //           });
            //         },
            //         child: Align(
            //           alignment: Alignment(-1, 0),
            //           child: Container(
            //             width: width * 0.5,
            //             color: Colors.transparent,
            //             alignment: Alignment.center,
            //             child: Text(
            //               "BUY",
            //               style: TextStyle(
            //                 color: todayColor,
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 17,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Align(
            //         alignment: Alignment.center,
            //         child: VerticalDivider(
            //           color: Colors.grey[300],
            //           thickness: 4,
            //           width: 2,
            //           endIndent: 10,
            //           indent: 10,
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             xAlign = signInAlign;
            //             tomorrowColor = Colors.green;
            //             selectedValue = false;
            //             todayColor = normalColor;
            //             pageController.animateToPage(1,
            //                 duration: Duration(milliseconds: 300),
            //                 curve: Curves.ease);
            //           });
            //         },
            //         child: Align(
            //           alignment: Alignment(1, 0),
            //           child: Container(
            //             width: width * 0.5,
            //             color: Colors.transparent,
            //             alignment: Alignment.center,
            //             child: Text(
            //               "SELL",
            //               style: TextStyle(
            //                 color: tomorrowColor,
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 17,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       AnimatedAlign(
            //         alignment: Alignment(xAlign, 1),
            //         duration: Duration(milliseconds: 300),
            //         child: Container(
            //           width: width * 0.5,
            //           height: 5,
            //           color: Colors.green,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    if (index == 0) {
                      xAlign = todayAlign;
                      todayColor = Colors.green;
                      tomorrowColor = normalColor;
                      selectedValue = true;
                    } else {
                      xAlign = signInAlign;
                      tomorrowColor = Colors.green;
                      selectedValue = false;
                      todayColor = normalColor;
                    }
                  });
                },
                children: [
                  getBuySection(),
                  getSellSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'Animals/buySection/animalBuy.dart';
// import 'Animals/sellSection/animalSell.dart';
// import 'Crops/buySection/cropBuy.dart';
// import 'Crops/sellSection/cropSell.dart';
// import 'Fertilizer/buySection/fertilizerBuy.dart';
// import 'Fertilizer/sellSection/fertilizerSell.dart';
// import 'Machinery/BuySection/machineBuy.dart';
// import 'Machinery/sellSection/machineSell.dart';
// import 'Seeds/BuySection/seedsBuy.dart';
// import 'Seeds/sellSection/seedsSell.dart';
//
// class Test extends StatefulWidget {
//   Test({required this.st});
//   final String st;
//
//   @override
//   _TestState createState() => _TestState();
// }
//
// class _TestState extends State<Test> with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverAppBar(
//             title: Text(widget.st),
//             centerTitle: true,
//             pinned: true,
//             floating: true,
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(48), // Adjust the height as needed
//               child: TabBar(
//                 controller: _tabController,
//                 tabs: [
//                   Tab(text: 'BUY'),
//                   Tab(text: 'SELL'),
//                 ],
//                 indicator: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.green,
//                       width: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             getBuySection(),
//             getSellSection(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget getBuySection() {
//     switch (widget.st) {
//       case "crops":
//         return CropBuy();
//       case "machine":
//         return MachineBuy();
//       case "Fertilizer":
//         return FertilizerBuy();
//       case "animal":
//         return AnimalsBuy();
//       case "seeds":
//         return SeedsBuy();
//       default:
//         return Container(); // Return an empty container or handle the case based on your requirements
//     }
//   }
//
//   Widget getSellSection() {
//     switch (widget.st) {
//       case "crops":
//         return SellSection();
//       case "machine":
//         return MachineSellSection();
//       case "Fertilizer":
//         return FertilizerSellSection();
//       case "animal":
//         return AnimalSellSection();
//       case "seeds":
//         return SeedsSellSection();
//       default:
//         return Container(); // Return an empty container or handle the case based on your requirements
//     }
//   }
// }
