import 'dart:convert';

import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  List<Map<String, dynamic>> allJuz = [];
  RxBool isDark = false.obs;
  RxBool adaDataAllJuz = false.obs;

//menyimpan data thema di lokal memory
  void changeThemeMode() async {
    Get.changeTheme(Get.isDarkMode ? themeLight : themeDark);
    isDark.toggle();
    final box = GetStorage();
    if (Get.isDarkMode) {
      //jika dari gelap ke terang, themedark remove
      box.remove("themeDark");
    } else {
      // jika dari terang ke gelap, maka kita set
      box.write("themeDark", true);
    }
  }

  //menampilkan allsurah
  List<Surah> allSurah = [];
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

//membuat bagian juz dengan ayat yang diambil dari allsurah
  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;

    List<Map<String, dynamic>> penampunganAyat = [];

    for (var i = 1; i <= 114; i++) {
      var res =
          await http.get(Uri.parse("https://api.quran.gading.dev/surah/$i"));
      Map<String, dynamic> rawData = json.decode(res.body)["data"];
      DetailSurah data = DetailSurah.fromJson(rawData);

      if (data.verses != null) {
        data.verses!.forEach((ayat) {
          if (ayat.meta?.juz == juz) {
            penampunganAyat.add({
              "surah": data,
              "ayat": ayat,
            });
          } else {
//logic untuk detail juz
            allJuz.add({
              "juz": juz,
              "start": penampunganAyat[0],
              "end": penampunganAyat[penampunganAyat.length - 1],
              "verses": penampunganAyat,
            });
            juz++;
            penampunganAyat = [];
            penampunganAyat.add({
              "surah": data,
              "ayat": ayat,
            });
          }
        });
      }
    }
    allJuz.add({
      "juz": juz,
      "start": penampunganAyat[0],
      "end": penampunganAyat[penampunganAyat.length - 1],
      "verses": penampunganAyat,
    });
    return allJuz;
  }

//tampil bookmark
  DatabaseManager database = DatabaseManager.instance;
  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmarks = await db.query(
      "bookmark",
      where: "last_read = 0",
      orderBy: "juz, via, surah, ayat",
    );
    return allBookmarks;
  }

//delete bookmark
  void deleteBookmark(int id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id = $id");
    update();
    Get.back(); //tutup dialog
    Get.snackbar('Berhasil', 'Hapus bookmark berhasil', colorText: appWhite);
  }

//tampil last read
  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> dataLastRead = await db.query(
      "bookmark",
      where: "last_read = 1 ",
    );
    if (dataLastRead.length == 0) {
      //jika tidak ada data lastread
      return null;
    } else {
      //ada data lastread, yang indexnya cuma 1 yaitu index ke 0 yang ada didalam list
      return dataLastRead.first;
    }
  }

  //delete lastread
}
