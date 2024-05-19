import 'package:farm_easy/user_onbording/user_provaider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'image_upload/image_selector.dart';

class Number_Auth extends StatefulWidget {
  Number_Auth({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<Number_Auth> createState() => _Number_AuthState();
}

class _Number_AuthState extends State<Number_Auth> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? User_Name;
  // bool? image = MyBottomSheet().imageUploded;

  String? OwnerName;
  bool img = false;
  String? imgpath;
  void updateImageStatus(bool uploaded) {
    setState(() {
      img = uploaded;
      print("updateImagePath ");
    });
  }

  void updateImagepath(String uploaded) {
    setState(() {
      imgpath = uploaded;
      print("updateImagePath " + imgpath!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('phone');

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/animation/Login.gif',
                  width: 250,
                  height: 200,
                ),
                Text(
                  "Login",
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Shop Name.';
                    }
                    return null;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: "User Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    User_Name = value;
                    //Do something with the user input.
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    // MyBottomSheet().showMyBottomSheet(context);
                    MyBottomSheet(
                      onImageUpload: updateImageStatus,
                      filePath: updateImagepath,
                    ).showMyBottomSheet(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      img != true
                          ? Text('Upload The Your Image')
                          : Text('uploded'),
                      // Image.asset(imgpath.toString())
                      // Image.file(imgpath),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                img == true
                    ? Image.file(
                        File(imgpath
                            .toString()), // Convert the path to a File object
                        height: 50,
                        width: 50,
                      )
                    : Text(''),
                SizedBox(
                  height: 10,
                ),

                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(
                        146, 227, 160, 1), // Set container background color
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors
                          .transparent, // Use transparent background for TextButton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      // Handle button press logic
                      if (_formKey.currentState!.validate()) {
                        // Perform actions when form is valid
                        var userProvider = context.read<UserProvaider>();
                        userProvider.putData(User_Name!, phone, imgpath!);

                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${countryController.text + phone}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {
                            print('${credential}  <==========>');
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            print(
                                '${e.toString()}  <==========>error===========>');
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            Number_Auth.verify = verificationId;
                            Navigator.pushNamed(context, 'verify');
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }
                    },
                    child: Text(
                      "Send the code",
                      style: TextStyle(
                        color: Colors.white, // Set button text color
                        fontSize: 16, // Set button text font size
                        // Set button text font weight
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
