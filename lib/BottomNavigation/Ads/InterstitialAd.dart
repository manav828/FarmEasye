import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../news/webView.dart';

class InterstitialAdPage extends StatefulWidget {
  // const InterstitialAdPage({Key? key}) : super(key: key);
  InterstitialAdPage({required this.url});
  String url;

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebView(url: widget.url! // Specify the URL here
                          ),
                ),
              );
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        }, onAdFailedToLoad: ((error) {
          interstitialAd.dispose();
        })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interstitial Ad"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (isAdLoaded) {
              interstitialAd.show();
            }
          },
          child: Text("Task completed"),
        ),
      ),
    );
  }
}
