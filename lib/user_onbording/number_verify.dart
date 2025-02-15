import 'dart:io';

// import 'package:charueats_delivery/user_onbording/user_provaider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_easy/user_onbording/user_provaider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

import 'login_check.dart';
import 'number_auth.dart';

class Number_verify extends StatefulWidget {
  const Number_verify({Key? key}) : super(key: key);

  @override
  State<Number_verify> createState() => _Number_verifyState();
}

class _Number_verifyState extends State<Number_verify> {
  // String? token;
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDeviceToken();
  }

  // Future<String> getDeviceToken() async {
  //   // token = await messaging.getToken();
  //   // print("$token device token");
  //   return token!;
  // }

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  String imageUrl = '';
  Future<bool> _uploadImage() async {
    print(File(context.read<UserProvaider>().getImage.toString()));
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref(
              'farm-easy-811e7.appspot.com') // Specify your custom bucket name here
          .child('Users')
          .child(context.read<UserProvaider>().getUserName!)
          .child('/' + '${context.read<UserProvaider>().getUserName!}.jpg');

      uploadTask = ref.putFile(File(context.read<UserProvaider>().getImage!));
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      print('Image URL => ' + imageUrl);

      var userProvaider = await context.read<UserProvaider>();
      userProvaider.imageUrl(imageUrl);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void sendUserData() async {
    // String ShopName = context.read<UserProvaider>().getUserName!;
    // // String? OwnerName = context.read<UserProvaider>().getOwnerName;
    // String? PhoneNumber = context.read<UserProvaider>().getPhone;
    // String? ImageUrl = context.read<UserProvaider>().getImageUrl;

    final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;
    try {
      await FirebaseFirestore.instance
          .collection('User Data')
          .doc(firebaseUser)
          .set({
        'UserName': context.read<UserProvaider>().getUserName,
        // 'OwnerName': context.read<UserProvaider>().getOwnerName,
        'PhoneNumber': context.read<UserProvaider>().getPhone,
        'ImageUrl': context.read<UserProvaider>().getUserImage,
        // 'token': token,
      });
      print('data uploded ==========================fefbjhfhekf');
    } catch (e) {
      print(e.toString());
    }

    //       .collection('UserData')
    //       .doc(firebaseUser)
    //       .collection('cart')
    //       .doc('${itemId}')
    //       .update({
    //     "itemCount": itemCount,
    //     "totalPrice": widget.finalTotal,
    //   });
  }

  @override
  Widget build(BuildContext context) {
    print('verify');

    // print(context.read<UserProvaider>().getShopName);
    // print(context.read<UserProvaider>().getOwnerName);
    // print(context.read<UserProvaider>().getPhone);
    // print(context.read<UserProvaider>().getImage.toString());

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    // final String verificationId =
    //     ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/animation/otp.gif',
                width: 250,
                height: 200,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (value) {
                  code = value;
                  print(code);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.yellow.shade700, Colors.yellow.shade500],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                // child: Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [
                //         Color(0xFF5BD2BC),
                //         // Color(0xFFFF5900),
                //       ],
                //       stops: [1.0],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.transparent,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onPressed: () async {
                //       bool isTrue = await _uploadImage();
                //       print(isTrue);
                //       try {
                //         if (Number_Auth.verify.isNotEmpty && code.isNotEmpty) {
                //           PhoneAuthCredential credential =
                //               PhoneAuthProvider.credential(
                //             verificationId: Number_Auth.verify,
                //             smsCode: code,
                //           );
                //
                //           // Sign the user in (or link) with the credential
                //           await auth.signInWithCredential(credential);
                //           await SharedPreferencesHelper.setLoggedIn(
                //               true); /////////////
                //           bool isTrue = await _uploadImage();
                //           print(isTrue);
                //
                //           //send data to firebase
                //           sendUserData();
                //
                //           Navigator.pushNamedAndRemoveUntil(
                //             context,
                //             'bottomNav',
                //             (route) => false,
                //           );
                //         } else {
                //           print("Verification ID or SMS code is empty.");
                //         }
                //       } catch (e) {
                //         print(e.toString() + ' <====error');
                //       }
                //     },
                //     child: Text("Verify Phone Number"),
                //   ),
                // ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        146, 227, 169, 1), // Set solid background color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      bool isTrue = await _uploadImage();
                      print(isTrue);
                      try {
                        if (Number_Auth.verify.isNotEmpty && code.isNotEmpty) {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: Number_Auth.verify,
                            smsCode: code,
                          );

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          await SharedPreferencesHelper.setLoggedIn(true);
                          bool isTrue = await _uploadImage();
                          print(isTrue);

                          // Send data to Firebase
                          sendUserData();

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'bottomNav',
                            (route) => false,
                          );
                        } else {
                          print("Verification ID or SMS code is empty.");
                        }
                      } catch (e) {
                        print(e.toString() + ' <====error');
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color.fromRGBO(146, 227, 169,
                              0.7); // Set button background color
                        },
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.transparent;
                          }
                          return Colors.transparent; // No overlay color
                        },
                      ),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                          minWidth: 200,
                          minHeight: 45), // Adjust size as needed
                      alignment: Alignment.center,
                      child: Text(
                        "Verify Phone Number",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'phone',
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
