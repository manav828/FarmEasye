import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'NewsModel.dart';

class CategoriesProvider with ChangeNotifier {
  List<String>? _categories;
  List<NewsModel>? _subsidyNewsData;
  List<NewsModel>? _newsData;

  List<String>? get categories => _categories;
  List<NewsModel>? get newsSubsidyData => _subsidyNewsData;
  List<NewsModel>? get newsData => _newsData;

  late NewsModel news;
  Future<void> fetchCategories() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Retrieve the document snapshot
      DocumentSnapshot snapshot =
          await firestore.collection('News').doc('9033741722').get();

      // Check if the snapshot exists and has data
      if (snapshot.exists && snapshot.data() != null) {
        // Access the 'collections' field from the snapshot and set it to _categories
        List<String> categoryList =
            List.from((snapshot.data() as Map<String, dynamic>)['collections']);
        // Filter out "Subsidy" and "Other" categories
        categoryList = categoryList
            .where((category) => category != "Subsidy" && category != "Other")
            .toList();
        _categories = categoryList;
        notifyListeners(); // Notify listeners about the change
      } else {
        print('Document snapshot does not exist or has no data');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  CategoriesProvider() {
    fetchDataForSubsidyCategory();
  }

  Future<void> fetchDataForSubsidyCategory() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<NewsModel> newList = [];
      // Retrieve the document snapshot for the provided category
      QuerySnapshot querySnapshot = await firestore
          .collection('News')
          .doc('9033741722')
          .collection('Subsidy')
          .get();

      for (var e in querySnapshot.docs) {
        news = NewsModel(
          date: e.get('date'),
          description: e.get('description'),
          heading: e.get('heading'),
          imageUrls: e.get('imageUrls'),
          time: e.get('time'),
          url: e.get('url'),
        );
        newList.add(news);
      }

      // Set the fetched data to _newsData
      _subsidyNewsData = newList;
      notifyListeners(); // Notify listeners about the change
    } catch (e) {
      print('Error fetching data for category : $e');
    }
  }

  Future<void> fetchDataForCategory(String categoryName) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<NewsModel> newList = [];
      // Retrieve the document snapshot for the provided category
      QuerySnapshot querySnapshot = await firestore
          .collection('News')
          .doc('9033741722')
          .collection(categoryName)
          .get();

      for (var e in querySnapshot.docs) {
        news = NewsModel(
          date: e.get('date'),
          description: e.get('description'),
          heading: e.get('heading'),
          imageUrls: e.get('imageUrls'),
          time: e.get('time'),
          url: e.get('url'),
        );
        newList.add(news);
      }

      // Set the fetched data to _newsData
      _newsData = newList;
      notifyListeners(); // Notify listeners about the change
    } catch (e) {
      print('Error fetching data for category : $e');
    }
  }
}
