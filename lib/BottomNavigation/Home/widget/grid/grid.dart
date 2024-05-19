import 'package:farm_easy/BottomNavigation/Home/widget/grid/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeGrid extends StatefulWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  State<HomeGrid> createState() => _HomeGridState();
}

List<String> imagePaths = [
  'assets/1.png',
  'assets/2.png',
  'assets/3.png',
  'assets/4.png',
  'assets/5.png',
];

class _HomeGridState extends State<HomeGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Add this line
      physics: NeverScrollableScrollPhysics(), // Add this line
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.2,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Test(st: "crops")),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Test(st: "machine")),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Test(st: "animal")),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Test(st: "seeds")),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Test(st: "Fertilizer")),
                );
                break;
            }
            // switch (index) {
            //   case 0:
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => CropsSection()),
            //     );
            //     break;
            //   case 1:
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MachinerySection()),
            //     );
            //     break;
            //   case 2:
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AnimalsSection()),
            //     );
            //     break;
            //   case 3:
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SeedsSection()),
            //     );
            //     break;
            //   case 4:
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => FertilizerSection()),
            //     );
            //     break;
            // }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 100,
            margin: EdgeInsets.all(8),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
