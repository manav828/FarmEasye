import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:csc_picker/csc_picker.dart';

import '../../../../../../ConstFields/constFields.dart';

class MachineSellSection extends StatefulWidget {
  const MachineSellSection({Key? key}) : super(key: key);

  @override
  State<MachineSellSection> createState() => _MachineSellSectionState();
}

class _MachineSellSectionState extends State<MachineSellSection> {
  final _formKey = GlobalKey<FormState>(); // Add form key

  List<String>? pickedImages = [];
  String? machineName;
  String? vahicalCompany;
  String? vahicalModel;
  String? ownerName;
  // String? ownerId;
  double? kmUsed;
  double? price;
  double? purchaseYear;
  var ownerPhone = "";
  String? address;
  String? description;
  String? state;
  String? city;

  TextEditingController countryController = TextEditingController();
  // final myKey = UniqueKey();
  bool _isSubmitting = false;
  // late final _imageCache = ImageCache(key: myKey); // Cache images efficiently
  // late final _imageCache = ImageCache();
  Future<void> _getImageFromGallery(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(pickedImage?.path);
    if (pickedImage != null) {
      setState(() {
        pickedImages!.add(pickedImage!.path);
      });
    }
  }

  late ImageCache _imageCache; // Declare _imageCache

  @override
  void initState() {
    super.initState();
    _imageCache = ImageCache(); // Initialize _imageCache here
    countryController.text = "+91";
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;

  Future<bool> _uploadData(List<String> imageUrls) async {
    try {
      // Get a reference to the Firestore database
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference machineDocumentReference = await firestore
          .collection('User Data')
          .doc(firebaseUser)
          .collection('Machines')
          .add({
        'machineName': machineName,
        'vahicalCompany': vahicalCompany,
        'vahicalModel': vahicalModel,
        'kmUsed': kmUsed,
        'price': price,
        'purchaseYear': purchaseYear,
        'address': address,
        'description': description,
        'state': state,
        'city': city,
        'ownerName': ownerName,
        'ownerPhone': ownerPhone,
        'imageUrls': imageUrls,
      });
      String machineDocumentId = machineDocumentReference.id;
      // Add a new document with a generated ID
      await firestore.collection('Machines').doc(machineDocumentId).set({
        'machineName': machineName,
        'vahicalCompany': vahicalCompany,
        'vahicalModel': vahicalModel,
        'kmUsed': kmUsed,
        'price': price,
        'purchaseYear': purchaseYear,
        'ownerName': ownerName,
        'ownerPhone': ownerPhone,
        'userId': firebaseUser,
        'address': address,
        'description': description,
        'state': state,
        'city': city,
        'imageUrls': imageUrls,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _uploadImages() async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < pickedImages!.length; i++) {
        String imagePath = pickedImages![i];
        firabase_storage.UploadTask uploadTask;

        firabase_storage.Reference ref = firabase_storage
            .FirebaseStorage.instance
            .ref(
                'farm-easy-811e7.appspot.com') // Specify your custom bucket name here
            .child('Users')
            .child('Machines')
            .child(machineName!)
            .child(
                '/${machineName}_$i.jpg'); // Use a unique name for each image

        uploadTask = ref.putFile(File(imagePath));
        await uploadTask.whenComplete(() => null);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
        print('Image URL => $imageUrl');
      }

      // Upload form data along with image URLs to Firestore
      bool isDataUploaded = await _uploadData(imageUrls);

      return isDataUploaded;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    _imageCache.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey, // Assign form key
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: pickedImages != null && pickedImages!.isNotEmpty
                            ? Image.file(
                                File(pickedImages![0]),
                                fit: BoxFit.cover,
                              )
                            : GestureDetector(
                                onTap: () {
                                  _getImageFromGallery(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 60,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      if (pickedImages != null && pickedImages!.isNotEmpty)
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                pickedImages!.removeAt(0);
                              });
                              // Handle delete image action
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.green,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      for (int i = 1; i < 4; i++)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _getImageFromGallery(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 130,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                    child: pickedImages != null &&
                                            pickedImages!.length > i
                                        ? Image.file(
                                            File(pickedImages![i]),
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.add_photo_alternate_outlined,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                  ),
                                ),
                                if (pickedImages != null &&
                                    pickedImages!.isNotEmpty)
                                  Positioned(
                                    top: -14,
                                    right: -10,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          pickedImages!.removeAt(i);
                                        });
                                        // Handle delete image action
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Your Name.';
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    style: TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      prefixIcon: Icon(Icons.ac_unit),
                      hintText: "Enter Your Name",
                    ),
                    onChanged: (value) {
                      ownerName = value;
                      //Do something with the user input.
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Machine Name.';
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    style: TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      prefixIcon: Icon(Icons.ac_unit),
                      hintText: "Machine Name",
                    ),
                    onChanged: (value) {
                      machineName = value;
                      //Do something with the user input.
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the branch or model.';
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "brand name",
                          ),
                          onChanged: (value) {
                            vahicalCompany = value;
                            //Do something with the user input.
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          validator: (value) {
                            // Validation logic
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Model Name",
                          ),
                          onChanged: (value) {
                            vahicalModel = value;
                            // Handle onChanged
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Price';
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "kilometers used",
                          ),
                          onChanged: (value) {
                            kmUsed = double.parse(value);
                            //Do something with the user input.
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // Validation logic
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "PurchaseYear",
                          ),
                          onChanged: (value) {
                            purchaseYear = double.parse(value);
                            // Handle onChanged
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Price Name.';
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    style: TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      prefixIcon: Icon(
                        Icons.currency_rupee,
                        color: Primery_color,
                      ),
                      hintText: "Price ",
                    ),
                    onChanged: (value) {
                      price = double.parse(value);
                      //Do something with the user input.
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                          child: TextFormField(
                            onChanged: (value) {
                              ownerPhone = value;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Description of Your Machine.';
                      }
                      return null;
                      // Validation logic
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    style: TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      hintText: "Enter Description",
                    ),
                    onChanged: (value) {
                      description = value;
                      // Handle onChanged
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Your Address.';
                      }
                      return null;
                      // Validation logic
                    },
                    // textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      // prefixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Enter Address",
                    ),
                    onChanged: (value) {
                      address = value;
                      // Handle onChanged
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CSCPicker(
                    defaultCountry: CscCountry.India,
                    disableCountry: false,
                    layout: Layout.vertical,
                    flagState: CountryFlag.DISABLE,
                    onCountryChanged: (country) {},
                    onStateChanged: (state) {
                      setState(() {
                        this.state = state;
                      });
                    },
                    onCityChanged: (city) {
                      setState(() {
                        this.city = city;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: // Submit Button
                  _isSubmitting
                      ? Center(
                          child:
                              CircularProgressIndicator(), // Show indicator while submitting
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                pickedImages != null &&
                                pickedImages!.isNotEmpty &&
                                state != null &&
                                city != null &&
                                ownerPhone != null &&
                                ownerPhone.length == 10) {
                              // If all fields are valid

                              setState(() {
                                _isSubmitting = true; // Show loading indicator
                              });

                              bool isTrue = await _uploadImages();

                              setState(() {
                                _isSubmitting = false; // Hide loading indicator
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Form submitted successfully!'),
                                ),
                              );
                              if (isTrue) {
                                // Reset form if data is successfully uploaded
                                // _formKey.currentState!.reset();

                                // Clear other form-related variables
                                setState(() {
                                  pickedImages!.clear();
                                  machineName = null;
                                  vahicalCompany = null;
                                  vahicalModel = null;
                                  kmUsed = null;
                                  price = null;
                                  ownerPhone = "";
                                  address = null;
                                  description = null;
                                  state = null;
                                  city = null;
                                });

                                // Show a success message (snackbar)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Form submitted successfully!'),
                                  ),
                                );
                              } else {
                                // Show error message if data upload fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Failed to submit form. Please try again later.'),
                                  ),
                                );
                              }
                            } else {
                              // If any field is empty, show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please fill all mandatory fields.'),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: _isSubmitting
                                ? Center(
                                    child:
                                        CircularProgressIndicator(), // Show indicator while submitting
                                  )
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
