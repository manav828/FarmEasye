import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;

  const WebView({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController controller;
  // final controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.disabled)
  //   ..loadRequest(Uri.parse(''));
  late BannerAd _bannerAd;
  late BannerAd _bannerAd2;

  @override
  void initState() {
    super.initState();

    controller = WebViewController();
    // controller.setJavaScriptMode(JavaScriptMode.disabled);
    controller.loadRequest(Uri.parse(widget.url));
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
      appBar: AppBar(
        title: Text("WebView Page"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: _bannerAd.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ),
      ),
    );
  }
}
