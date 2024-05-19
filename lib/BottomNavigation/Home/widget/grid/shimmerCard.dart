import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5, // Adjust the number of shimmer items as needed
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 13.0,
            horizontal: 20.0,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 255,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                child: Column(
                  children: [
                    Container(
                      height: 180, // Adjust the height of the image container
                      width: double.infinity,
                      color: Colors.grey, // Placeholder color for image
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:
                                  20, // Adjust the height of the text container
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: Colors.grey, // Placeholder color for text
                            ),
                            SizedBox(height: 5),
                            Container(
                              height:
                                  15, // Adjust the height of the text container
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: Colors.grey, // Placeholder color for text
                            ),
                          ],
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height:
                                  15, // Adjust the height of the text container
                              width:
                                  90, // Adjust the width of the text container
                              color: Colors.grey, // Placeholder color for text
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
