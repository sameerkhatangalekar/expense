import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'categories_logic.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoriesLogic>();

    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
         navigationBar:  const CupertinoNavigationBar(
          // leading: IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.back,)),
          middle: Text('Categories'),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Obx(() => controller.categories.isEmpty ? const Center(child: Text('No Categories'),) : CupertinoFormSection.insetGrouped(
                    children: controller.categories.map((element) =>
                        CupertinoFormRow(
                          padding: const EdgeInsets.all(10),
                          prefix: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: element.color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    width: 2)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                element.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),).toList()
                )
                ),
              ),
            ),
            SafeArea(
              bottom: true,
              left: true,
              right: true,
              top: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() =>
                      GestureDetector(
                        onTap: (){
                          _showColorPicker(context);
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: controller.selectedColor.value,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  width: 2)),
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      controller: controller.categoryNameController,
                      clearButtonMode: OverlayVisibilityMode.always,
                      placeholder: 'Enter category name',
                      placeholderStyle: const TextStyle(color: Colors.white),

                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Form(
                      key: controller.key,
                      child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Colors.blueAccent,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),

                          onPressed: () {
                            if (controller.categoryNameController.text.isNotEmpty) {
                                controller.insertCategory(controller.categoryNameController.text.trim(), controller.selectedColor.value.value);
                            }
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ));

  }
  _showColorPicker (BuildContext context) {

  final controller = Get.find<CategoriesLogic>();
    return ColorPicker(
      color: controller.selectedColor.value,
      onColorChanged: (Color color) {
        controller.selectedColor.value = color;
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },

    ).showPickerDialog(
      context,
      transitionBuilder: (BuildContext context,
          Animation<double> a1,
          Animation<double> a2,
          Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(
              0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints: const BoxConstraints( minWidth: 300, maxWidth: 320),
    );
  }


}
