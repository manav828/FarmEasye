import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_easy/BottomNavigation/Home/widget/grid/grid.dart';

import 'package:farm_easy/BottomNavigation/Home/widget/slider/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../ConstFields/constFields.dart';
import '../../splash_screen/splash_screen.dart';
import '../../user_onbording/login_check.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  String UserName = '';
  String imageLink = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('User Data')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          UserName = ds.get('UserName');
          imageLink = ds.get('ImageUrl');
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f5f7),
      key: _scaffoldState,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,

          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return UserAccountsDrawerHeader(
                  accountName: Text(UserName.toString()),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        imageLink,
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                  accountEmail: null,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_outlined),
              title: const Text('Favorites'),
              onTap: () => null,
            ),
            ListTile(
              leading: const Icon(Icons.history_edu_outlined),
              title: const Text('History'),
              onTap: () => null,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: const Icon(Icons.document_scanner),
              title: const Text('Policies'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              title: const Text('Exit'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                _auth.signOut();
                await FirebaseAuth.instance.signOut();
                await SharedPreferencesHelper.setLoggedIn(false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _scaffoldState.currentState?.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: BgColor,
                      ),
                    ),
                    Text(
                      'Farm Easy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green,
                          width: 2.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.fill,
                          height: 65,
                          width: 65,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Search(),
              const SizedBox(
                height: 10,
              ),
              const ImgSlider(),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 18.0, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Services",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              const HomeGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
