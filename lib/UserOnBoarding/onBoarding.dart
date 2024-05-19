import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class onBording extends StatefulWidget {
  const onBording({Key? key}) : super(key: key);

  @override
  State<onBording> createState() => _onBordingState();
}

final pageController = PageController();
final selectedIndex = ValueNotifier(0);

final animation = [
  "assets/animation/2.json",
  "assets/animation/1.json",
  "assets/animation/3.json"
];
final title = ["Crop Marketplace", "Seeds Exchange", "Vehicle Hub"];
final desc = [
  "Explore and trade a diverse range of crops effortlessly.",
  " Find the perfect seeds or sell surplus with ease.",
  "Buy, sell, or rent farm vehicles hassle-free."
];

class _onBordingState extends State<onBording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: animation.length,
                itemBuilder: (context, index) {
                  return _pageLayout(
                    animation: animation[index],
                    title: title[index],
                    desc: desc[index],
                  );
                },
                onPageChanged: (value) {
                  selectedIndex.value = value;
                },
              ),
            ),
            ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, index, child) {
                  return Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 32),
                      child: Wrap(
                        spacing: 8,
                        children:
                            List.generate(animation.length, (indexIndicator) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 8,
                            width: indexIndicator == index ? 24 : 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: indexIndicator == index
                                    ? Colors.green
                                    : Colors.green.shade200),
                          );
                        }),
                      ));
                }),
            Padding(
              padding: EdgeInsets.all(24),
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, index, child) {
                  if (index == animation.length - 1) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'phone');
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        child: const Text("Get Started"),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          // pageController.jumpToPage(
                          //     animation.length - 1);
                          final nextPage = animation.length - 1;
                          pageController.animateToPage(nextPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease); // Corrected spelling
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                        child: const Text(
                          "skip",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final nextPage = selectedIndex.value + 1;
                          pageController.animateToPage(nextPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            // foregroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _pageLayout extends StatelessWidget {
  const _pageLayout({
    required this.animation,
    required this.title,
    required this.desc,
  });

  final String animation;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    // Define heading text style
    final TextStyle headingStyle = TextStyle(
      // textAlign: TextAlign.center,
      fontFamily: 'Roboto',
      fontSize: 24, // Adjust font size as needed
      fontWeight: FontWeight.bold, // Adjust font weight as needed
      color: Colors.black, // Adjust color as needed
    );

    // Define description text style
    final TextStyle descriptionStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16, // Adjust font size as needed
      color: Colors.black87, // Adjust color as needed
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset(animation),
          ),
          // Adding some space between animation and title
          Text(
            title,
            style: headingStyle,
          ),
          SizedBox(
              height: 8), // Adding some space between title and description
          Text(
            desc,
            style: descriptionStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
