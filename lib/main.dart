import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/constant/color.dart';

import 'app/routes/app_pages.dart';

import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  runApp(
    GetMaterialApp(
      theme: box.read("themeDark") == null ? themeLight : themeDark,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
