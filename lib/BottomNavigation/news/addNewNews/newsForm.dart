import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../../../ConstFields/constFields.dart';

class NewsForm extends StatefulWidget {
  @override
  _NewsFormState createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  String? pickedImage; // Define a variable to hold the picked image path
  final _formKey = GlobalKey<FormState>();
  Future<void> _getImageFromGallery(BuildContext context) async {
    // Define a function to pick an image from the gallery
    final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource
            .gallery); // Use ImagePicker to pick an image from the gallery
    if (pickedImageFile != null) {
      // Check if an image is picked
      setState(() {
        pickedImage =
            pickedImageFile.path; // Set the picked image path to the variable
      });
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;
  String? imageUrl;

  late ImageCache _imageCache; // Declare _imageCache

  @override
  void initState() {
    super.initState();
    _imageCache = ImageCache();
    _fetchCollectionList();
  }

  List<String>? _collections;
  Future<List<String>> _fetchCollectionList() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Retrieve the document snapshot
      DocumentSnapshot snapshot =
          await firestore.collection('News').doc('9033741722').get();

      // Check if the snapshot exists and has data
      if (snapshot.exists && snapshot.data() != null) {
        // Access the 'collections' field from the snapshot and return it as a list
        List<String> collectionList =
            List.from((snapshot.data() as Map<String, dynamic>)['collections']);
        setState(() {
          _collections = collectionList;
        });
        print(collectionList);
        return collectionList;
      } else {
        print('Document snapshot does not exist or has no data');
        return [];
      }
    } catch (e) {
      print('Error fetching collection list: $e');
      return [];
    }
  }

  Future<void> _addCollection(String newCollection) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Retrieve the current list of collections
      // DocumentSnapshot snapshot = await firestore.collection('News').doc('9033741722').get();
      List<String>? currentCollections = _collections;

      // Add the new collection name to the list
      int index = currentCollections!.length - 1;
      currentCollections?.insert(index, newCollection);

      // Update the list of collections in Firestore
      await firestore
          .collection('News')
          .doc('9033741722')
          .update({'collections': currentCollections});
    } catch (e) {
      print('Error adding collection: $e');
    }
  }

  Future<bool> _uploadImage(String collection) async {
    try {
      firabase_storage.UploadTask? uploadTask;
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref(
              'farm-easy-811e7.appspot.com') // Specify your custom bucket name here
          .child('News')
          .child(collection)
          .child('/' + '${timestamp}.jpg');

      uploadTask = ref.putFile(File(pickedImage!));
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      print('Image URL => ' + imageUrl!);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _uploadData(String selectedCollection, String imageUrl) async {
    try {
      // Get a reference to the Firestore database
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current date and time
      DateTime now = DateTime.now();
      String formattedDate =
          DateFormat('dd/MM/yyyy').format(now); // Format date as dd/MM/yyyy
      String formattedTime =
          DateFormat('HH:mm:ss').format(now); // Format time as HH:mm:ss

      // Add a new document with a generated ID in the specified collection
      await firestore
          .collection('News')
          .doc("9033741722")
          .collection(selectedCollection)
          .add({
        'heading': _heading,
        'description': _description,
        'url': _url,
        'imageUrls': imageUrl,
        'date': formattedDate,
        'time': formattedTime,
        // Add other fields as needed
      });

      return true;
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

  String _selectedCollection = 'Subsidy';
  String _manualCollectionName =
      ''; // Added variable to store manual collection name
  String _heading = '';
  String _description = '';
  String _url = '';
  bool _showManualCollectionName =
      false; // Flag to show manual collection name field

  // List<String> _collections = [
  //   'Subsidy',
  //   'Weather',
  //   'Farming News',
  //   'India News',
  //   'New Technology in Farming',
  //   'Other',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: pickedImage != null // Check if an image is picked
                          ? Image.file(
                              // If an image is picked, display it
                              File(
                                  pickedImage!), // Use Image.file to display the picked image
                              fit: BoxFit
                                  .cover, // Set the fit property to cover the container
                            )
                          : GestureDetector(
                              // If no image is picked, display a placeholder with the option to pick an image
                              onTap: () {
                                _getImageFromGallery(
                                    context); // Call the function to pick an image from the gallery when tapped
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
                    if (pickedImage !=
                        null) // If an image is picked, display a delete button
                      Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              pickedImage =
                                  null; // Set the picked image to null when delete button is pressed
                            });
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
                DropdownButtonFormField<String>(
                  value: _selectedCollection,
                  items: _collections?.map((collection) {
                    return DropdownMenuItem<String>(
                      value: collection,
                      child: Text(collection),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCollection = newValue!;
                      print(_selectedCollection);
                      if (_selectedCollection == 'Other') {
                        _showManualCollectionName = true;
                      } else {
                        _showManualCollectionName = false;
                      }
                    });
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Select Collection',
                  ),
                ),
                // SizedBox(height: 20),
                _showManualCollectionName == true
                    ? // Show text field only when "Other" is selected

                    Column(
                        children: [
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Enter Collection Name',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _manualCollectionName = value;
                              });
                            },
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 20),
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Heading',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _heading = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a heading';
                      }
                    }),
                SizedBox(height: 20),
                TextFormField(
                    maxLines: 4,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Description',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Description';
                      }
                    }),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'News Resource URL',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _url = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a URL';
                      }
                    }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Validate form
                      bool uploadImage = false;
                      bool uploaded = false;
                      if (_manualCollectionName.isEmpty) {
                        uploadImage = await _uploadImage(_selectedCollection);

                        if (uploadImage) {
                          uploaded = await _uploadData(
                              _selectedCollection, imageUrl ?? '');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to add news'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      } else {
                        uploadImage = await _uploadImage(_manualCollectionName);
                        if (uploadImage) {
                          uploaded = await _uploadData(
                              _manualCollectionName, imageUrl ?? '');
                          _addCollection(_manualCollectionName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to add news'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      }

                      if (uploaded) {
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('News added successfully'),
                          duration: Duration(seconds: 2),
                        ));
                        // Clear form fields
                        setState(() {
                          pickedImage = null;
                          _selectedCollection = 'Subsidy';
                          _manualCollectionName = '';
                          _heading = '';
                          _description = '';
                          _url = '';
                        });
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to add news'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
