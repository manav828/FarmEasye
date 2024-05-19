import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../../ConstFields/constFields.dart';

import '../../UniSlider/UniImageSlider.dart';

import 'getMachineBuyHome/getMachineHomeModel.dart';

class MachineProductView extends StatefulWidget {
  // const ProductView({Key? key}) : super(key: key);
  MachineProductView({super.key, required this.data});
  BuyMachineHomeDataModel data;

  @override
  State<MachineProductView> createState() => _MachineProductViewState();
}

class _MachineProductViewState extends State<MachineProductView> {
  late BannerAd _bannerAd;
  late BannerAd _bannerAd2;

  @override
  void initState() {
    super.initState();
    // Create a BannerAd instance
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-3940256099942544/9214589741', // Replace with your actual ad unit ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    _bannerAd2 = BannerAd(
      adUnitId:
          'ca-app-pub-3940256099942544/9214589741', // Replace with your actual ad unit ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    // Load the ad
    _bannerAd.load();
    _bannerAd2.load();
  }

  @override
  void dispose() {
    // Dispose of the ad when the widget is disposed
    _bannerAd.dispose();
    _bannerAd2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(top: 100, bottom: 70, left: 28, right: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: UniImgSlider(
                            ratio: 1,
                            imgUrls: widget.data.imageUrls,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Row(
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.all(8.0),
                      //       child: CircleAvatar(
                      //         radius: 20.0,
                      //         backgroundImage: AssetImage('assets/abc.jpg'),
                      //       ),
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Farmer Name',
                      //           style: SubHeadingStyle,
                      //         ),
                      //         Text(
                      //           'Manav Satasiya',
                      //           style: SubTextStyle,
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      Positioned(
                        bottom: 80, // Adjust as needed
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: AdWidget(ad: _bannerAd),
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                        ),
                      ),
                      Text(
                        widget.data.machineName!,
                        textAlign: TextAlign.left,
                        style: HeadingStyle,
                      ),
                      // SizedBox(height: 8),
                      SizedBox(height: 10),

                      Text(
                        "Company Name",
                        style: SubHeadingStyle,
                      ),
                      Text(
                        "${widget.data.vahicalCompany}",
                        style: SubTextStyle,
                      ),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vahical Model",
                            style: SubHeadingStyle,
                          ),
                          Text(
                            "${widget.data.vahicalModel}",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price",
                            style: SubHeadingStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                "${widget.data.price}₹",
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Text(
                        "Purchase Year",
                        style: SubHeadingStyle,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.data.purchaseYear!.toInt()}",
                        style: SubTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),

                      Text(
                        "Total Killometers used",
                        style: SubHeadingStyle,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.data.kmUsed!.toInt()}",
                        style: SubTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),

                      Text(
                        "Description",
                        style: SubHeadingStyle,
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.data.description!,
                        style: SubTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),

                      Text(
                        "Address",
                        style: SubHeadingStyle,
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.data.address!,
                        style: SubTextStyle,
                        textAlign: TextAlign.justify,
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Location",
                        style: SubHeadingStyle,
                      ),
                      Text(
                        "${widget.data.city}, ${widget.data.state}, India",
                        style: SubTextStyle,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Owner Name",
                        style: SubHeadingStyle,
                      ),
                      Text(
                        widget.data.ownerName!,
                        style: SubTextStyle,
                      ),
                      SizedBox(height: 10),
                      Positioned(
                        bottom: 80, // Adjust as needed
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: AdWidget(ad: _bannerAd2),
                          width: _bannerAd2.size.width.toDouble(),
                          height: _bannerAd2.size.height.toDouble(),
                        ),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 28),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  Text(
                    "Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_border),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 28),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: TextButton(
                        onPressed: () {
                          // Add your onPressed logic for message button
                        },
                        child: Text(
                          "Message",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        onPressed: () {
                          // Add your onPressed logic for call button
                        },
                        child: Text(
                          "Call",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
