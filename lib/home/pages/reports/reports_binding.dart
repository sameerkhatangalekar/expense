import 'package:get/get.dart';

import 'reports_logic.dart';

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportsLogic());
  }
}
