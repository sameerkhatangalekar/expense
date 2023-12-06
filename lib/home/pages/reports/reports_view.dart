import 'package:expense/extensions/date_extensions.dart';
import 'package:expense/extensions/expense_extensions.dart';
import 'package:expense/extensions/number_extensions.dart';
import 'package:expense/home/pages/reports/charts/monthly_chart.dart';
import 'package:expense/home/pages/reports/charts/weekly_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/periods.dart';
import '../../components/expense_list.dart';
import 'charts/yearly_chart.dart';
import 'reports_logic.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportsLogic>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        middle: const Text("Reports", style: TextStyle(
          fontSize: 20,)),
        trailing: CupertinoButton(
          child: const Icon(CupertinoIcons.calendar),
          onPressed: () => showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                  height: 216,
                  padding: const EdgeInsets.only(top: 6.0),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: -1,
                    ),
                    magnification: 1,
                    squeeze: 1.2,
                    useMagnifier: false,
                    itemExtent: 34,
                    onSelectedItemChanged: (int selectedItem) {
                      controller.periodIndex.value = selectedItem + 1;
                    },
                    children:
                        List<Widget>.generate(periods.length - 1, (int index) {
                      return Center(
                        child: Text(periods[index + 1].name),
                      );
                    }),
                  ),
                );
              }),
        ),
      ),
      child: SafeArea(
        child: Obx(() => PageView.builder(
              controller: controller.pageController,
              onPageChanged: (newPage) => controller.updateCurrentPage(newPage),
              itemCount: controller.numberOfPages.value != 1
                  ? controller.numberOfPages.value
                  : null,
              reverse: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    "${controller.startDate.value.shortDate} ${controller.startDate.value.shortYear} - ${controller.endDate.value.shortDate} ${controller.endDate.value.shortYear}",
                                    style: const TextStyle(fontSize: 20),
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    const Text(
                                      "INR ",
                                      style: TextStyle(
                                        color: CupertinoColors.inactiveGray,
                                      ),
                                    ),
                                    Obx(() {
                                      return Text(
                                        controller.spentInPeriod.value
                                            .removeDecimalZeroFormat(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Avg/day",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    const Text(
                                      "INR ",
                                      style: TextStyle(
                                        color: CupertinoColors.inactiveGray,
                                      ),
                                    ),
                                    Obx(() => Text(
                                        controller.avgPerDay.value
                                            .removeDecimalZeroFormat(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      [
                        WeeklyChart(
                            expenses: controller.expenses.groupWeekly()),
                        MonthlyChart(
                          expenses: controller.expenses,
                          startDate: controller.startDate.value,
                          endDate: controller.endDate.value,
                        ),
                        YearlyChart(expenses: controller.expenses)
                      ][controller.periodIndex.value - 1],
                      Obx(() => controller.expenses.isEmpty
                          ? const Text('No data for selected period!')
                          : Expanded(
                              child: ExpensesList(
                                displayedExpenses: controller
                                    .computeExpenses(controller.expenses),
                              ),
                            ))
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
