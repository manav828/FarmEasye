import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:csc_picker/csc_picker.dart';

import '../../../../../../ConstFields/constFields.dart';

class SeedsSellSection extends StatefulWidget {
  const SeedsSellSection({Key? key}) : super(key: key);

  @override
  State<SeedsSellSection> createState() => _SeedsSellSectionState();
}

class _SeedsSellSectionState extends State<SeedsSellSection> {
  final _formKey = GlobalKey<FormState>(); // Add form key

  List<String>? pickedImages = [];
  String? seedName;
  String? seedType;
  String? breedOfSeed;
  String? description;
  String? variety;
  String? address;
  double? expectedYield;
  double? weight;
  String? plantingSeason;
  String? requiredSoilCondition;
  double? requiredPHofWater;
  String? ownerPhone;
  String? ownerName;
  String? CompanyName;
  double? price;
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

      DocumentReference seedsDocumentReference = await firestore
          .collection('User Data')
          .doc(firebaseUser)
          .collection('Seeds')
          .add({
        'seedName': seedName,
        'seedType': seedType,
        'variety': variety,
        'price': price,
        'CompanyName': CompanyName,
        'expectedYield': expectedYield,
        'plantingSeason': plantingSeason,
        'ownerPhone': ownerPhone,
        'ownerName': ownerName,
        'userId': firebaseUser,
        'address': address,
        'weight': weight,
        // 'description': description,
        'state': state,
        'city': city,
        'imageUrls': imageUrls,
        // 'requiredSoilCondition': requiredSoilCondition,
        'requiredPHofWater': requiredPHofWater,
      });
      String seedDocumentId = seedsDocumentReference.id;

      // Add a new document with a generated ID
      await firestore.collection('Seeds').doc(seedDocumentId).set({
        'seedName': seedName,
        'weight': weight,
        'seedType': seedType,
        'variety': variety,
        'price': price,
        'expectedYield': expectedYield,
        'plantingSeason': plantingSeason,
        'ownerPhone': ownerPhone,
        'ownerName': ownerName,
        'CompanyName': CompanyName,
        'userId': firebaseUser,
        'address': address,
        // 'description': description,
        'state': state,
        'city': city,
        'imageUrls': imageUrls,
        // 'requiredSoilCondition': requiredSoilCondition,
        'requiredPHofWater': requiredPHofWater,
      });
      await firestore
          .collection('User Data')
          .doc(firebaseUser)
          .collection('Seeds')
          .add({
        'seedName': seedName,
        'seedType': seedType,
        'variety': variety,
        'price': price,
        'CompanyName': CompanyName,
        'expectedYield': expectedYield,
        'plantingSeason': plantingSeason,
        'ownerPhone': ownerPhone,
        'ownerName': ownerName,
        'userId': firebaseUser,
        'address': address,
        'weight': weight,
        // 'description': description,
        'state': state,
        'city': city,
        'imageUrls': imageUrls,
        // 'requiredSoilCondition': requiredSoilCondition,
        'requiredPHofWater': requiredPHofWater,
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
            .child('Seeds')
            .child(seedName!)
            .child('/${seedName}_$i.jpg'); // Use a unique name for each image

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
                        child: pickedImages != null &&
                                (pickedImages?.isNotEmpty ?? false)
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
                                  child: const Center(
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
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.green,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                                  margin: const EdgeInsets.only(right: 10),
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
                                        : const Icon(
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
                                          pickedImages?.removeAt(i);
                                        });
                                        // Handle delete image action
                                      },
                                      icon: const Icon(
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
                  const SizedBox(
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
                    style: const TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      prefixIcon: const Icon(Icons.ac_unit),
                      hintText: "Enter Your Name",
                    ),
                    onChanged: (value) {
                      ownerName = value;
                      //Do something with the user input.
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      //add dropdown for seed type(fruits,vegitable,crop,flower
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: seedType, // Current selected value
                          decoration: textInputDecoration.copyWith(
                            prefixIcon: const Icon(Icons.ac_unit),
                            hintText: "Seed Type",
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'fruits',
                              child: Text('Fruits'),
                            ),
                            DropdownMenuItem(
                              value: 'vegetables',
                              child: Text('Vegetables'),
                            ),
                            DropdownMenuItem(
                              value: 'crops',
                              child: Text('Crops'),
                            ),
                            DropdownMenuItem(
                              value: 'flowers',
                              child: Text('Flowers'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              seedType = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a seed type.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a seedName Name.';
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            prefixIcon: const Icon(Icons.ac_unit),
                            hintText: "seedName Name",
                          ),
                          onChanged: (value) {
                            seedName = value;
                            //Do something with the user input.
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the variety';
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "variety name",
                          ),
                          onChanged: (value) {
                            variety = value;
                            //Do something with the user input.
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          validator: (value) {
                            // Validation logic
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "CompanyName Name",
                          ),
                          onChanged: (value) {
                            CompanyName = value;
                            // Handle onChanged
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
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
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Price used",
                          ),
                          onChanged: (value) {
                            price = double.parse(value);
                            //Do something with the user input.
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // Validation logic
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "weight in KG",
                          ),
                          onChanged: (value) {
                            weight = double.parse(value);
                            // Handle onChanged
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a expectedYield.';
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      hintText: "expectedYield per acer in kg",
                    ),
                    onChanged: (value) {
                      expectedYield = double.parse(value);
                      //Do something with the user input.
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              ownerPhone = value;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: plantingSeason, // Current selected value
                    decoration: textInputDecoration.copyWith(
                      prefixIcon: const Icon(Icons.ac_unit),
                      hintText: "Planting Season",
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Winter',
                        child: Text('Winter'),
                      ),
                      DropdownMenuItem(
                        value: 'Summer',
                        child: Text('Summer'),
                      ),
                      DropdownMenuItem(
                        value: 'Rainy',
                        child: Text('Rainy'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        plantingSeason = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a planting season.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    //MAKE drop down(winter, summer , rainy)
                    // maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the PH level required of water';
                      }
                      return null;
                      // Validation logic
                    },
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      hintText: "required PH of Water",
                    ),
                    onChanged: (value) {
                      requiredPHofWater = double.parse(value);
                      // Handle onChanged
                    },
                  ),
                  const SizedBox(
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
                    style: const TextStyle(color: Colors.black),
                    decoration: textInputDecoration.copyWith(
                      // prefixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Enter Address",
                    ),
                    onChanged: (value) {
                      address = value;
                      // Handle onChanged
                    },
                  ),
                  const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: // Submit Button
                  _isSubmitting
                      ? const Center(
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
                                ownerPhone?.length == 10) {
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
                                  seedName = null;
                                  seedType = null;
                                  weight = null;
                                  variety = null;
                                  expectedYield = null;
                                  plantingSeason = null;
                                  requiredSoilCondition = null;
                                  CompanyName = null;
                                  requiredPHofWater = null;

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
                                ? const Center(
                                    child:
                                        CircularProgressIndicator(), // Show indicator while submitting
                                  )
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
