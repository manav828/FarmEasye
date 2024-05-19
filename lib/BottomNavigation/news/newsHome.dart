// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:farm_easy/BottomNavigation/news/webView.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../ConstFields/constFields.dart';
// import 'newsDesign/coustomButton.dart';
// import 'addNewNews/newsForm.dart';
// import 'newsDesign/newsItem.dart';
// import 'newsDesign/newsRow.dart';
//
// class NewsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final String phoneNumber = '9033741722';
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Latest News'),
//         actions: [
//           Visibility(
//             visible: phoneNumber == '9033741722',
//             child: IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 // Navigate to the new screen here
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => NewsForm()),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       body: NewsHorizontalList(), // Display the horizontal list of news items
//     );
//   }
// }
//
// class NewsHorizontalList extends StatefulWidget {
//   @override
//   _NewsHorizontalListState createState() => _NewsHorizontalListState();
// }
//
// class _NewsHorizontalListState extends State<NewsHorizontalList> {
//   int _selectedIndex = 0; // Select "Farming" by default
//   final List<String> _categories = ['Farming', 'Cricket', 'Subsidy', 'Weather'];
//   Color _selectedColor =
//       Colors.blue; // Initialize selected color to blue for "Farming"
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           FractionallySizedBox(
//             widthFactor: 0.85,
//             child: Text(
//               "Subsidy News",
//               style: SubHeadingStyle,
//               textAlign: TextAlign.left,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Container(
//               height: 270,
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context)
//                         .size
//                         .width, // Set width to screen width
//                     // height: 400,
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => WebView(
//                                 url:
//                                     'https://pmkmy.gov.in/scheme/pmkmy' // Specify the URL here
//                                 ),
//                           ),
//                         );
//                       },
//                       child: NewsItem(
//                         imageUrl: 'assets/t1.jpg', // Placeholder image URL
//                         heading: 'News Heading 1',
//                         description:
//                             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit augue eu ante tempor, nec sodales justo condimentum.',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context)
//                         .size
//                         .width, // Set width to screen width
//                     // height: 400,
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => WebView(
//                                 url:
//                                     'https://groww.in/p/savings-schemes/pm-kisan-samman-nidhi-yojana' // Specify the URL here
//                                 ),
//                           ),
//                         );
//                       },
//                       child: NewsItem(
//                         imageUrl: 'assets/t2.jpg', // Placeholder image URL
//                         heading: 'Pradhan Mantri Kisan Samman Nidhi Yojana',
//                         description:
//                             'The Pradhan Mantri Kisan Samman Nidhi Yojana (PM-Kisan Yojana) is a government of India-initiated scheme that aims to provide minimum income support of up to Rs. 6000 to all small and marginal farmers per year.',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18.0),
//             child: Column(
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: List.generate(
//                       _categories.length,
//                       (index) => CustomButton(
//                         text: _categories[index],
//                         isSelected: index == _selectedIndex,
//                         onPressed: () {
//                           setState(() {
//                             _selectedIndex = index;
//                             // _selectedColor = _getColorForIndex(index);
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 AnimatedContainer(
//                     // height: _selectedIndex == -1 ? 0 : 500,
//                     duration: Duration(milliseconds: 300),
//                     // color: _selectedColor,
//                     child: Container(
//                       padding: EdgeInsets.only(top: 8.0),
//                       margin: EdgeInsets.symmetric(vertical: 4.0),
//                       decoration: BoxDecoration(
//                         // border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Column(
//                         children: [
//                           NewsRow(
//                             imageUrl: 'assets/s1.jpg',
//                             heading: 'News Heading 1',
//                             description:
//                                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit augue eu ante tempor, nec sodales justo condimentum.',
//                             onTapUrl:
//                                 'https://example.com', // Replace with actual URL
//                           ),
//                           SizedBox(height: 10),
//                           NewsRow(
//                             imageUrl: 'assets/s2.jpg',
//                             heading: 'News Heading 1',
//                             description:
//                                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit augue eu ante tempor, nec sodales justo condimentum.',
//                             onTapUrl:
//                                 'https://example.com', // Replace with actual URL
//                           ),
//                           SizedBox(height: 10),
//                           NewsRow(
//                             imageUrl: 'assets/s3.png',
//                             heading: 'News Heading 1',
//                             description:
//                                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit augue eu ante tempor, nec sodales justo condimentum.',
//                             onTapUrl:
//                                 'https://example.com', // Replace with actual URL
//                           ),
//                           SizedBox(height: 10),
//                           NewsRow(
//                             imageUrl: 'assets/s1.jpg',
//                             heading: 'News Heading 1',
//                             description:
//                                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit augue eu ante tempor, nec sodales justo condimentum.',
//                             onTapUrl:
//                                 'https://example.com', // Replace with actual URL
//                           ),
//                           SizedBox(height: 10),
//                         ],
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:farm_easy/BottomNavigation/news/webView.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../ConstFields/constFields.dart';
import '../Ads/InterstitialAd.dart';
import 'addNewNews/newsForm.dart';
import 'fatchData/NewsModel.dart';
import 'fatchData/newsProvaider.dart';
import 'newsDesign/coustomButton.dart';
import 'newsDesign/newsItem.dart';
import 'newsDesign/newsRow.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String phoneNumber = '9033741722';
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
        actions: [
          Visibility(
            visible: phoneNumber == '9033741722',
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Navigate to the new screen here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsForm()),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<CategoriesProvider>(
        builder: (context, provider, child) {
          // Fetch categories using the provider
          provider.fetchCategories();
          provider.fetchDataForSubsidyCategory();
          return NewsHorizontalList();
        },
      ),
    );
  }
}

class NewsHorizontalList extends StatefulWidget {
  @override
  _NewsHorizontalListState createState() => _NewsHorizontalListState();
}

class _NewsHorizontalListState extends State<NewsHorizontalList> {
  int _selectedIndex = 0; // Select "Farming" by default
  Color _selectedColor =
      Colors.blue; // Initialize selected color to blue for "Farming"

  @override
  void initState() {
    super.initState();
    print(Provider.of<CategoriesProvider>(context, listen: false).categories);
    Provider.of<CategoriesProvider>(context, listen: false)
        .fetchDataForCategory('Weather');
    initIntersititalAd();
  }

  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;

  initIntersititalAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          setState(() {
            isAdLoaded = true;
          });
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              initIntersititalAd();

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         WebView(url: widget.url! // Specify the URL here
              //         ),
              //   ),
              // );
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              // ad.dispose();
            },
          );
        }, onAdFailedToLoad: ((error) {
          interstitialAd.dispose();
        })));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, child) {
        // Check if categories are fetched
        if (provider.categories == null) {
          // Show loading indicator while categories are being fetched
          return Center(child: CircularProgressIndicator());
        } else {
          // Once categories are fetched, build the UI
          List<String> _categories = provider.categories!;
          // Function to handle button press
          void handleButtonPress(String category) {
            Provider.of<CategoriesProvider>(context, listen: false)
                .fetchDataForCategory(category);
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Text(
                    "Subsidy News",
                    style: SubHeadingStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 270,
                    child: Row(
                      children: provider.newsSubsidyData!.map((e) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              if (isAdLoaded) {
                                interstitialAd.show();
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebView(
                                      url: e.url! // Specify the URL here
                                      ),
                                ),
                              );
                            },
                            child: NewsItem(
                              imageUrl: e.imageUrls!, // Placeholder image URL
                              heading: e.heading!,
                              description: e.description!,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _categories.map((category) {
                            int index = _categories.indexOf(category);
                            return CustomButton(
                              text: category,
                              isSelected: index == _selectedIndex,
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = index;
                                  handleButtonPress(category);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          padding: EdgeInsets.only(top: 8.0),
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Consumer<CategoriesProvider>(
                            builder: (context, provider, child) {
                              List<NewsModel>? newsData = provider.newsData;
                              if (newsData != null) {
                                return Column(
                                  children: newsData.map((e) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (isAdLoaded) {
                                              interstitialAd.show();
                                            }
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         InterstitialAdPage(
                                            //             url: e
                                            //                 .url! // Specify the URL here
                                            //             ),
                                            //   ),
                                            // );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => WebView(
                                                    url: e
                                                        .url! // Specify the URL here
                                                    ),
                                              ),
                                            );
                                          },
                                          child: NewsRow(
                                            imageUrl: e.imageUrls!,
                                            heading: e.heading!,
                                            description: e.description!,
                                            onTapUrl: e.url!,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  }).toList(),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
