import 'package:expense/categories/categories_binding.dart';
import 'package:expense/categories/categories_view.dart';
import 'package:expense/home/home_binding.dart';
import 'package:expense/home/home_view.dart';
import 'package:expense/home/pages/reports/reports_binding.dart';
import 'package:expense/home/pages/reports/reports_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      GetCupertinoApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,

        ],
    title: 'Expense',
    theme: const CupertinoThemeData(
      primaryColor: Color.fromARGB(255, 41, 141, 255),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      textTheme: CupertinoTextThemeData(

          navTitleTextStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white),
          textStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              color: Colors.white)),
      barBackgroundColor: Colors.black,
    ),
    getPages: [
      GetPage(
        name: '/',
        page: () => const HomePage(),
        transition: Transition.cupertino,
        binding: HomeBinding(),
      ),
      GetPage(
        name: '/categories',
        page: () => const CategoriesPage(),
        transition: Transition.cupertino,
        binding: CategoriesBinding(),
      ),
      GetPage(
        name: '/reports',
        page: () => const ReportsPage(),
        transition: Transition.cupertino,
        binding: ReportsBinding(),
      )

    ],
    initialRoute: '/',
  ));
}
