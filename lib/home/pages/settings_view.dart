import 'package:expense/home/home_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.find<HomeLogic>();
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text(
            'Settings',
            style: TextStyle(

                fontSize: 20,),
          ),
        ),
        child: SafeArea(
            child:CupertinoFormSection.insetGrouped(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.toNamed('/categories');
                      },
                      child: const CupertinoFormRow(
                        padding: EdgeInsets.all(10),
                        prefix: Text(
                          'Categories',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              ),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 20,
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text('Are you sure?'),
                              content: const Text('This action cannot be undone.\nThis will erase expenses & categories!'),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: const Text(
                                    'Erase',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: (){
                                      controller.eraseAllData();
                                      Get.back();
                                      Get.snackbar('', '',titleText: const Text('Success',style: TextStyle(color: CupertinoColors.white),),messageText: const Text('All the transaction data is erased',style: TextStyle(color: CupertinoColors.white),) ,icon: const Icon(CupertinoIcons.checkmark_seal_fill,color: CupertinoColors.activeGreen,));
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: const CupertinoFormRow(
                      padding: EdgeInsets.all(10),
                      prefix: Text(
                        'Erase all data',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            ),
                      ),
                      child: Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  )
                ]),

        ));
  }


}
