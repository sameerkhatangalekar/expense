import 'package:expense/extensions/expense_extensions.dart';
import 'package:expense/extensions/number_extensions.dart';
import 'package:expense/home/components/expense_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/expense.dart';
import '../../realm.dart';
import '../../utils/periods.dart';
import '../home_logic.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeLogic>();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Expense',
          style: TextStyle(

              fontSize: 20,
              ),
        ),
      ),
      child:
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total for: '),
                CupertinoButton(
                  onPressed: () =>
                      showCupertinoModalPopup(
                          context: context, builder: (context) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: CupertinoColors.systemBackground
                                  .resolveFrom(context),
                              borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: controller.selectedPeriodIndex.value),
                            magnification: 1,
                            squeeze: 1.2,
                            useMagnifier: false,
                            itemExtent: 34,
                            onSelectedItemChanged: (int selectedItem) {
                              controller.selectedPeriodIndex.value = selectedItem;
                              controller.expenses.value = realm.all<Expense>().toList().filterByPeriod(periods[controller.selectedPeriodIndex.value], 0)[0];
                            },
                            children: List<Widget>.generate(
                                periods.length, (int index) {
                              return Center(child: Text(getPeriodDisplayName(periods[index])),
                              );
                            }),
                          ),
                        );
                      }),
                  child: Obx(() => Text(getPeriodDisplayName(controller.selectedPeriod))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                  child: const Text("₹",
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.inactiveGray,
                      )),
                ),
                Obx(() => Text(controller.total.value.removeDecimalZeroFormat(),
                      style: const TextStyle(
                        fontSize: 40,
                      ))
                ),
              ],
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
                  child: Obx(() {
                    return ExpensesList(
                        displayedExpenses: controller.computeExpenses(
                            controller.expenses));
                  })
              ),
            )
          ],
        ),
      ),


    );
  }
}
