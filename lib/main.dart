import 'package:farm_easy/splash_screen/splash_screen.dart';
import 'package:farm_easy/user_onbording/number_auth.dart';
import 'package:farm_easy/user_onbording/number_verify.dart';
import 'package:farm_easy/user_onbording/user_provaider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'BottomNavigation/BottomNav.dart';
import 'BottomNavigation/Home/home.dart';
import 'BottomNavigation/Home/widget/grid/Animals/buySection/getAnimalsBuyHome/AnimalHomeProvaider.dart';
import 'BottomNavigation/Home/widget/grid/Crops/buySection/getCropsBuyHome/cropsHomeProvaider.dart';
import 'BottomNavigation/Home/widget/grid/Fertilizer/buySection/getFertilizerBuyHome/FertilizerHomeProvaider.dart';
import 'BottomNavigation/Home/widget/grid/Machinery/BuySection/getMachineBuyHome/machineHomeProvaider.dart';
import 'BottomNavigation/Home/widget/grid/Seeds/BuySection/getSeeds/seedsHomeProvaider.dart';
import 'BottomNavigation/Profile/getListedProduct/getProfileData.dart';
import 'BottomNavigation/news/fatchData/newsProvaider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCTyBnfkMC51ZKp0W-k9VorXtB5d84d8EM',
          appId: '1:355824436402:android:6f1cd1a7fb52d8bc79f5ab',
          messagingSenderId: '355824436402',
          projectId: 'farm-easy-811e7',
          storageBucket: 'farm-easy-811e7.appspot.com'));

  // final storage = FirebaseStorage.instanceFor(bucket: 'manav');
  // final storage = FirebaseStorage.instance;
  runApp(MaterialApp(
    // initialRoute: 'mainhome',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider<MainItemProvaider>(
          //   create: (context) => MainItemProvaider(),
          // ),
          ChangeNotifierProvider<UserProvaider>(
            create: (context) => UserProvaider(),
          ),
          ChangeNotifierProvider<CropProvider>(
            create: (context) => CropProvider(),
          ),
          ChangeNotifierProvider<AnimalProvider>(
            create: (context) => AnimalProvider(),
          ),
          ChangeNotifierProvider<MachineProvider>(
            create: (context) => MachineProvider(),
          ),
          ChangeNotifierProvider<FertilizerProvider>(
            create: (context) => FertilizerProvider(),
          ),
          ChangeNotifierProvider<SeedsProvider>(
            create: (context) => SeedsProvider(),
          ),
          ChangeNotifierProvider<UserDataProvider>(
            create: (context) => UserDataProvider(),
          ),
          ChangeNotifierProvider<CategoriesProvider>(
            create: (context) => CategoriesProvider(),
          ),
        ],
        child: MaterialApp(
          // initialRoute: 'splashScreen',
          home: SplashScreen(),

          routes: {
            'phone': (context) => Number_Auth(),
            'verify': (context) => Number_verify(),
            'bottomNav': (context) => BottomNav(),
            'mainhome': (context) => MainHome(),
            'splashScreen': (context) => SplashScreen(),
            // 'bottom': (context) => BottomNav(),
          },
        ));
  }
}
