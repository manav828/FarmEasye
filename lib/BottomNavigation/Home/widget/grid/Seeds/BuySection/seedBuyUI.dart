import 'package:farm_easy/BottomNavigation/Home/widget/grid/Seeds/BuySection/seedsProductPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UniSlider/UniImageSlider.dart';
import 'getSeeds/getSeedsModel.dart';

class SeedBuyUI extends StatelessWidget {
  SeedBuyUI({required this.e});
  SeedSellModel e;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeedsProductView(
                    data: e,
                  )),
        );
      },
      child: Container(
        // decoration: new BoxDecoration(
        //   boxShadow: [
        //   new BoxShadow(
        //   color: Colors.black,
        //   blurRadius: 20.0,
        // ),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Color(0x22222617),
            blurRadius: 50,
          )
        ]),
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.black,
          // color: Colors.white,
          child: Container(
            height: 255,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              child: Column(
                children: [
                  // Image.asset(
                  //   "assets/abc.jpg",
                  //   height: 235,
                  //   width: MediaQuery.of(context).size.width,
                  //   fit: BoxFit.cover,
                  // ),
                  UniImgSlider(
                    imgUrls: e.imageUrls,
                    ratio: 16 / 9,
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.seedName!.length > 20
                                  ? '${e.seedName!.substring(0, 25)}...'
                                  : e.seedName!,

                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize:
                                      18), // Moved style inside Text widget
                              textAlign: TextAlign
                                  .end, // This will have no effect, as it's aligned to the start
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.green,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${e.city} , ${e.state}",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 12,
                                          color: Colors.green),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "₹ ${e.price}",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
