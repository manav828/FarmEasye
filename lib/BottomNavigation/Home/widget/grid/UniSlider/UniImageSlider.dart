import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UniImgSlider extends StatefulWidget {
  UniImgSlider({this.imgUrls, @required this.ratio});
  final List<String>? imgUrls;
  final double? ratio;

  @override
  State<UniImgSlider> createState() => _UniImgSliderState();
}

class _UniImgSliderState extends State<UniImgSlider> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double? imageAspectRatio =
        widget.ratio; // Adjust this based on your image aspect ratio

    return Stack(
      children: [
        CarouselSlider(
          items: widget.imgUrls?.map((item) {
                return Container(
                  width: screenWidth,
                  height: screenWidth / imageAspectRatio!,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(
                      item, // Use Image.network to load images from URLs
                    ),
                  ),
                );
              }).toList() ??
              [],
          carouselController: carouselController,
          options: CarouselOptions(
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlay: true,
            aspectRatio: imageAspectRatio!,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgUrls?.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == entry.key
                            ? Colors.red
                            : Colors.teal,
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
