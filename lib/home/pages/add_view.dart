import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_logic.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeLogic>();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add',style: TextStyle(

          fontSize: 20,),

        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: CupertinoFormSection.insetGrouped(

                children: [
                  CupertinoTextFormFieldRow(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (amount){
                      if(amount != null &&  GetUtils.isNum(amount))
                      {
                        return null;
                      }
                      return 'Enter valid amount';
                    },
                    prefix: const Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),

                    padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    placeholderStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white24),
                    placeholder: 'Amount',
                    controller: controller.amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  CupertinoFormRow(
                    prefix: const Text(
                      'Recurrence',
                      style: TextStyle(fontSize: 17),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.systemBackground
                                      .resolveFrom(context),
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                  initialItem: 0,
                                ),
                                magnification: 1,
                                squeeze: 1.2,
                                useMagnifier: false,
                                itemExtent: 34.0,
                                onSelectedItemChanged: (int selectedItem) {
                                  controller.selectedRecurrence.value =
                                      controller.recurrences[selectedItem];
                                },
                                children: List<Widget>.generate(
                                    controller.recurrences.length, (int index) {
                                  return Text(
                                    controller.recurrences[index],
                                  );
                                }),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() => Text(
                                controller.selectedRecurrence.value,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            CupertinoIcons.chevron_up_chevron_down,
                            color: Colors.white54,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CupertinoFormRow(
                    prefix: const Text(
                      'Date',
                      style: TextStyle(fontSize: 17),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: CupertinoButton(
                      onPressed: () => showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.systemBackground
                                      .resolveFrom(context),
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: CupertinoDatePicker(
                                initialDateTime: controller.selectedDate.value,
                                mode: CupertinoDatePickerMode.dateAndTime,
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newTime) {
                                  controller.selectedDate.value = newTime;
                                },
                              ),
                            );
                          }),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Colors.white10.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Obx(() => Text(
                              '${controller.selectedDate.value.month}/${controller.selectedDate.value.day}/${controller.selectedDate.value.year} ${controller.selectedDate.value.hour}:${controller.selectedDate.value.minute}',
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (note) {
                      if(note != null && note.isNotEmpty)
                        {
                          return null;
                        }
                      return 'Note cannot be empty';
                    },
                    prefix: const Text(
                      'Note',
                      style: TextStyle(fontSize: 17),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    placeholder: 'Note',
                    placeholderStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white24),
                    controller: controller.noteController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  CupertinoFormRow(
                    prefix: const Text(
                      'Category',
                      style: TextStyle(fontSize: 17),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.systemBackground
                                      .resolveFrom(context),
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                  initialItem: 0,
                                ),
                                magnification: 1,
                                squeeze: 1.2,
                                useMagnifier: false,
                                itemExtent: 34.0,
                                onSelectedItemChanged: (int selectedItem) {
                                  controller.selectedCategory.value = controller.categories[selectedItem];
                                },
                                children:    controller.categories.map((element) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: element.color,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white,
                                              strokeAlign: BorderSide.strokeAlignOutside,
                                              width: 2)),
                                    ),
                                    Text(
                                      element.name,
                                    ),
                                  ],
                                )).toList()


                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() => Text(
                            controller.selectedCategory.value.name,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          )),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            CupertinoIcons.chevron_up_chevron_down,
                            color: Colors.white54,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoButton.filled(
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if(controller.formKey.currentState!.validate())
                    {
                      controller.submitExpense();
                      Get.snackbar('', '',titleText: const Text('Success',style: TextStyle(color: CupertinoColors.white),),messageText: const Text('Expense added!',style: TextStyle(color: CupertinoColors.white),) ,icon: const Icon(Icons.currency_rupee_sharp,color: CupertinoColors.activeGreen,));

                    }
                })
          ],
        ),
      ),
    );
  }
}
