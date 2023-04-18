import 'package:alquran/app/modules/home/views/home_view.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import '../../../constant/color.dart';

import 'package:get/get.dart';

import '../controllers/introduction_controller.dart';
import 'package:lottie/lottie.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "AL-Quran Apps",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Alhamdulillah kamu masih mengingatku. Yuk... Baca Al-Quran Beserta Artinya.",
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 250,
                height: 250,
                child: Lottie.asset("assets/lotties/wanitamengaji.json",
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              child: Text(
                "AYO MULAI",
                style:
                    TextStyle(color: Get.isDarkMode ? appPurpleDark : appWhite),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                  backgroundColor: Get.isDarkMode ? appWhite : appPurpleDark),
            ),
          ],
        ),
      ),
    );
  }
}
