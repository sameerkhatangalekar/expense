import 'package:expense/models/category.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'models/expense.dart';

void dataCb(Realm realm) {
  realm.add<Category>(Category('Other', Colors.tealAccent.value));
}

var _config = Configuration.local([
  Category.schema,
  Expense.schema

], initialDataCallback:dataCb);


var realm = Realm(_config);
