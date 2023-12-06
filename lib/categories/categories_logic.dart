import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:expense/models/category.dart';
import 'package:expense/realm.dart';
import 'package:flutter/material.dart';




import 'package:get/get.dart';
import 'package:realm/realm.dart';

class CategoriesLogic extends GetxController {
  GlobalKey key   = GlobalKey<FormState>();
  Rx<Color> selectedColor =   const Color(0xFFFF6D00).obs;
  final TextEditingController categoryNameController  = TextEditingController();

  RxList<Category> categories = <Category>[].obs;
  StreamSubscription<RealmResultsChanges<Category>>? categorySubscription;


  @override
  void onInit() {
    initSubscription();
    super.onInit();
  }

  initSubscription(){
    categories.value  = realm.all<Category>().toList();
    categorySubscription ??= realm
        .all<Category>()
        .changes
        .listen((event) {
      categories.value = event.results.toList();
    });
  }
  @override
  void onClose() {
   categoryNameController.dispose();
   categorySubscription?.cancel();
    super.onClose();
  }

  insertCategory(String category, int inputColor){
      realm.write<Category>(() => realm.add(Category(category,inputColor)));
      categoryNameController.clear();
  }


}
