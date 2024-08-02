import 'package:get/get.dart';

import 'controllers/DioController.dart';
import 'controllers/ThemeController.dart';

void initilizeControllers() {
  Get.put(ThemeController(), permanent: true);
  Get.put(DioController(), permanent: true);
}
