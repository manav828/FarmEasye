// import 'package:charueats_shop/BottomNavigation/statatics/statistics.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
//
// import 'history/history.dart';
// import 'home/home.dart';
// import 'orders/orders.dart';
//
// class mainHomePageDesign extends StatefulWidget {
//   @override
//   State<mainHomePageDesign> createState() => _State();
// }
//
// class _State extends State<mainHomePageDesign> {
//   int _currentIndex = 0;
//   var _pageData = [MainHome(), OrderDeatils(), Statistics(), History()];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         child: _pageData[_currentIndex],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: _currentIndex,
//       //   selectedItemColor: Colors.black,
//       //   unselectedItemColor: Colors.grey,
//       //   items: const <BottomNavigationBarItem>[
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home),
//       //       // icon: Icon(Icons.home),
//       //       backgroundColor: Colors.white,
//       //       label: 'Home',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.shopping_bag_outlined),
//       //       label: 'Order',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.bar_chart_outlined),
//       //       label: 'Statistics',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.history_outlined),
//       //       label: 'History',
//       //     ),
//       //   ],
//       //   onTap: (index) {
//       //     setState(() {
//       //       print(index);
//       //       _currentIndex = index;
//       //       // print(_currentIndex);
//       //     });
//       //   },
//       // ),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.white,
//         color: Colors.yellow.shade200,
//         animationDuration: Duration(microseconds: 300),
//         items: [
//           Icon(
//             Icons.home,
//             color: Colors.red,
//           ),
//           Icon(
//             Icons.shopping_bag_outlined,
//             color: Colors.red,
//           ),
//           Icon(
//             Icons.bar_chart_outlined,
//             color: Colors.red,
//           ),
//           Icon(
//             Icons.history_outlined,
//             color: Colors.red,
//           )
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             // print(_currentIndex);
//           });
//         },
//       ),
//     );
//
//     // bottomN
//     // );
//     // }
//   }
// }

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_easy/BottomNavigation/Chat/chat.dart';
import 'package:flutter/material.dart';

import '../ConstFields/constFields.dart';
import 'Home/home.dart';
import 'Profile/Profile.dart';
import 'news/newsHome.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final _pageData = [
    const MainHome(),
    const MainChat(),
    NewsScreen(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageData[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: BgColor,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.chat_bubble,
            color: Colors.white,
          ),
          Icon(
            Icons.event_note_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
