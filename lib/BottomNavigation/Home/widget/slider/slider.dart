import 'package:flutter/cupertino.dart';

class ImgSlider extends StatefulWidget {
  const ImgSlider({Key? key}) : super(key: key);

  @override
  State<ImgSlider> createState() => _ImgSliderState();
}

class _ImgSliderState extends State<ImgSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: double.infinity, // Adjust the width as needed
        height: 190, // Adjust the height as needed

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20), // Adjust the radius as needed
          image: DecorationImage(
            image: AssetImage(
                'assets/b1.png'), // Replace 'assets/banner_image.png' with your image path
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
