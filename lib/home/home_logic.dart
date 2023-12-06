import 'dart:async';

import 'package:expense/extensions/date_extensions.dart';
import 'package:expense/extensions/expense_extensions.dart';
import 'package:expense/home/pages/reports/reports_logic.dart';
import 'package:expense/mock/mock_expenses.dart';
import 'package:expense/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../models/expense.dart';
import '../realm.dart';
import '../utils/periods.dart';
import '../utils/recurrence.dart';

class HomeLogic extends GetxController {
  late Rx<Category> selectedCategory;
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  var recurrences = List.from(Recurrence.values);
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Expense> expenses = <Expense>[].obs;
  RxString selectedRecurrence = ''.obs;
  StreamSubscription<RealmResultsChanges<Category>>? categorySubscription;
  StreamSubscription<RealmResultsChanges<Expense>>? expenseSubscription;
  RxInt selectedPeriodIndex = 1.obs;

  Period get selectedPeriod => periods[selectedPeriodIndex.value];

  RxDouble total = 0.0.obs;

  @override
  void onInit() {
    Get.lazyPut(() => ReportsLogic());
    selectedRecurrence.value = recurrences[0];

    initSubscription();
    ever(expenses, (callback) => total.value = callback.sum());
    super.onInit();
  }

  initSubscription() {
    expenses.value = mockExpenses;
    debugPrint(expenses.value.length.toString());
    expenses.value =
        realm.all<Expense>().toList().filterByPeriod(selectedPeriod, 0)[0];
    total.value = expenses.sum();
    categories.value = realm.all<Category>().toList();
    selectedCategory = categories.first.obs;
    expenseSubscription ??= realm.all<Expense>().changes.listen((event) {
      expenses.value =
          event.results.toList().filterByPeriod(selectedPeriod, 0)[0];
    });

    categorySubscription ??= realm.all<Category>().changes.listen((event) {
      categories.value = event.results.toList();
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    noteController.dispose();
    categorySubscription?.cancel();
    expenseSubscription?.cancel();
    super.onClose();
  }

  void submitExpense() {
    realm.write(() => realm.add<Expense>(Expense(
          ObjectId(),
          double.parse(amountController.value.text),
          selectedDate.value,
          category: selectedCategory.value,
          note: noteController.text.trim(),
          recurrence: selectedRecurrence.value,
        )));
    amountController.clear();
    selectedDate.value = DateTime.now();
    noteController.clear();
  }

  Map<DateTime, List<Expense>> computeExpenses(List<Expense> expenses) {
    Map<DateTime, List<Expense>> groups = {};
    for (final Expense expense in expenses) {
      final DateTime date = expense.date.simpleDate;
      if (groups.containsKey(date)) {
        groups[date]!.add(expense);
      } else {
        groups[date] = [expense];
      }
    }
    return Map.fromEntries(groups.entries.toList()
      ..sort((el1, el2) => el2.key.compareTo(el1.key)));
  }

  eraseAllData() {
    realm.write(() {
      realm.deleteAll<Expense>();
      realm.deleteAll<Category>();
      realm.add<Category>(Category('Other', Colors.tealAccent.value));
    });
  }
}
