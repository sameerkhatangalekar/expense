import 'package:expense/home/pages/add_view.dart';
import 'package:expense/home/pages/expense_view.dart';
import 'package:expense/home/pages/reports/reports_view.dart';

import 'package:expense/home/pages/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        activeColor: Colors.blueAccent,
        inactiveColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tray_arrow_up), label: 'Expenses'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar_fill), label: 'Reports'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add_circled), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: 'Settings')
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return const ExpensesView();
          case 1:
            return const ReportsPage();
          case 2:
            return  const AddView();
          case 3:
            return const SettingsView();
          default:
            return const ExpensesView();
        }
      },
    );
  }
}
