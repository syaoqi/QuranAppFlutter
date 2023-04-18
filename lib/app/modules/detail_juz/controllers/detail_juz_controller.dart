import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class DetailJuzController extends GetxController {
  int index = 0;
  DatabaseManager database = DatabaseManager.instance;
  AutoScrollController scrollC = AutoScrollController();
  bool flagExist = false;

  Future<void> addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          columns: [
            "surah",
            "number_surah",
            "ayat",
            "juz",
            "via",
            "index_ayat",
            "last_read"
          ],
          where:
              "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' and number_surah = ${surah.number!} and ayat = ${ayat.number!.inSurah!} and juz = ${ayat.meta!.juz!} and via = 'juz' and index_ayat = $indexAyat and last_read = 0");
      if (checkData.length != 0) {
        // ada data
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert(
        "bookmark",
        {
          "surah": "${surah.name!.transliteration!.id!.replaceAll("'", "+")}",
          "number_surah": surah.number!,
          "ayat": ayat.number!.inSurah!,
          "juz": ayat.meta!.juz!,
          "via": "juz",
          "index_ayat": indexAyat,
          "last_read": lastRead == true ? 1 : 0,
        },
      );
      Get.back();
      Get.snackbar("Berhasil", "Menambahkan ayat ke bookmark",
          colorText: appWhite);
    } else {
      Get.back();
      Get.snackbar("Gagal", "Ayat ini sudah ditambahkan ke bookmark",
          colorText: appWhite);
    }

    //db.query("bookmark") -> select all data dari table bookmark
    var data = await db.query("bookmark");
    print(data);
  }
}
