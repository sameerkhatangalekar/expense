import 'dart:async';

import 'package:expense/extensions/date_extensions.dart';
import 'package:expense/extensions/expense_extensions.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../../../realm.dart';
import '../../../utils/periods.dart';

class ReportsLogic extends GetxController {
  final PageController pageController = PageController(initialPage: 0);

  RxDouble spentInPeriod = 0.0.obs;
  RxDouble avgPerDay = 0.0.obs;

  StreamSubscription<RealmResultsChanges<Expense>>? expensesSub;

  RxList<Expense> expenses = <Expense>[].obs;

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;

  RxInt periodIndex = 1.obs;
  RxInt numberOfPages = 1.obs;

  late List<Expense> realmExpenses;

  @override
  void onInit() {
    initSubscription();
    setStateValues(0);
    updateNumberOfPages(periodIndex.value);
    ever(periodIndex, (newPeriod) {

      updatePeriod(newPeriod);
      updateNumberOfPages(newPeriod);
    });
    super.onInit();
  }

  initSubscription() {
    realmExpenses = realm.all<Expense>().toList();
  }

  updateNumberOfPages(int newPeriod) {
    switch (periods[newPeriod]) {
      case Period.day:
        numberOfPages.value = 365;
        break;
      case Period.week:
        numberOfPages.value = 53;
        break;
      case Period.month:
        numberOfPages.value = 12;
        break;
      case Period.year:
        numberOfPages.value = 1;
        break;
    }

  }

  updatePeriod(int newPeriod) {

    setStateValues(0);
    pageController.jumpToPage(0);
  }

  updateCurrentPage(int newPage) {

    setStateValues(newPage);
  }

  void setStateValues(int page) {
    var filterResults = realmExpenses.filterByPeriod(periods[periodIndex.value], page);
    var expensesList = filterResults[0] as List<Expense>;
    var start = filterResults[1] as DateTime;
    var end = filterResults[2] as DateTime;
    var numOfDays = end.difference(start).inDays + 1;
    expenses.value = expensesList;
    startDate.value = start;
    endDate.value = end;
    spentInPeriod.value = expenses.sum();
    avgPerDay.value = spentInPeriod.value / numOfDays;
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
}
