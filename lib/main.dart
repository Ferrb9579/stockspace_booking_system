import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routing.dart';
import 'controllers.dart';

void main() {
  initilizeControllers();
  runApp(
    GetMaterialApp(
      title: "Task Manager",
      initialRoute: "/${AppRoutes.splash}",
      color: Colors.white,
      getPages: AppPages.routes,
    ),
  );
}
