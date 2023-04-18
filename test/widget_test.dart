import 'dart:convert';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  // var res = await http.get(url);
  // // print(res.body);
  // List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  //  print(data);
  // print(data[113]);
  // Surah surahAnnas = Surah.fromJson(data[0]);
  // // print(surahAnnas.name);

//   Uri url2 =
// Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
//  var respon = await http.get(url2);
// Map<String, dynamic > dataAnnas = (json.decode(respon.body) as Map<String, dynamic>)["data"];
// DetailSurah detailsurahannas = DetailSurah.fromJson(dataAnnas);
// print(detailsurahannas.verses?[5].text?.arab);


//  int juz = 1;

//     List<Map<String, dynamic>> penampungAyat = [];
//     List<Map<String, dynamic>> allJuz = [];

//     for (var i = 1; i <= 114; i++) {
//       var res =
//           await http.get(Uri.parse("https://api.quran.gading.dev/surah/$i"));
//       Map<String, dynamic> rawData = json.decode(res.body)["data"];
//       DetailSurah data = DetailSurah.fromJson(rawData);

//       if (data.verses != null) {
//         data.verses!.forEach((ayat) {
//           if (ayat.meta?.juz == juz) {
//             penampungAyat.add({
//               "surah": data.name?.transliteration?.id ?? '',
//               "ayat": ayat,
//             });
//           } else {
//             allJuz.add({
//               "juz": juz,
//               "start": penampungAyat[0],
//               "end": penampungAyat[penampungAyat.length - 1],
//               "verses": penampungAyat,
//             });
//             juz++;
//             penampungAyat.clear();
//             penampungAyat.add({
//               "surah": data.name?.transliteration?.id ?? '',
//               "ayat": ayat,
//             });
//           }
//         });
//       }
//     }
//     allJuz.add({
//       "juz": juz,
//       "start": penampungAyat[0],
//       "end": penampungAyat[penampungAyat.length - 1],
//       "verses": penampungAyat,
//     });
//     print(allJuz[0]["verses"]);
  //   var res =
//       await http.get(Uri.parse("https://api.quran.gading.dev/surah/108/1"));
//   Map<String, dynamic> data = json.decode(res.body)["data"];

// //comvert mapping ayat to model ayat
//   Ayat ayat = Ayat.fromJson(data);
//   print(ayat.tafsir?.id?.short);
  // Uri url = Uri.parse("https://api.quran.gading.dev/juz/5");
  // var res = await http.get(url);

  // Map<String, dynamic> data =
  //     (json.decode(res.body) as Map<String, dynamic>)["data"];

  // //get surah 114 annas, karena mulai dari index ke 0, jadi surah annas ada di index ke 113
  // Juz juz = Juz.fromJson(data);
  // print(juz.juzStartInfo);
  // print(juz.juzEndInfo);

  // int juz = 1;

  // List<Map<String, dynamic>> penampunganAyat = [];
  // List<Map<String, dynamic>> allJuz = [];

  // for (var i = 1; i <= 114; i++) {
  //   var res =
  //       await http.get(Uri.parse("https://api.quran.gading.dev/surah/$i"));
  //   Map<String, dynamic> rawData = json.decode(res.body)["data"];
  //   DetailSurah data = DetailSurah.fromJson(rawData);

  //   if (data.verses != null) {
  //     data.verses!.forEach((ayat) {
  //       if (ayat.meta?.juz == juz) {
  //         penampunganAyat.add({
  //           "surah": data.name?.transliteration?.id ?? '',
  //           "ayat": ayat,
  //         });
  //       } else {
  //         print("====================");
  //         print("BERHASIL MEMASUKAN JUZ $juz");
  //         print("START");
  //         print(
  //             "Ayat : ${(penampunganAyat[0]["ayat"] as Verse).number?.inSurah}");
  //         print((penampunganAyat[0]["ayat"] as Verse).text?.arab);
  //         print("END");
  //         print(
  //             "Ayat : ${(penampunganAyat[penampunganAyat.length - 1]["ayat"] as Verse).number?.inSurah}");
  //         print((penampunganAyat[penampunganAyat.length - 1]["ayat"] as Verse)
  //             .text
  //             ?.arab);
  //         allJuz.add({
  //           "juz": juz,
  //           "start": penampunganAyat[0],
  //           "end": penampunganAyat[penampunganAyat.length - 1],
  //           "verse": penampunganAyat,
  //         });
  //         juz++;
  //         penampunganAyat.clear();
  //         penampunganAyat.add({
  //           "surah": data.name?.transliteration?.id ?? '',
  //           "ayat": ayat,
  //         });
  //       }
  //     });
  //   }
  // }
  // print("====================");
  // print("BERHASIL MEMASUKAN JUZ $juz");
  // print("START");
  // print("Ayat : ${(penampunganAyat[0]["ayat"] as Verse).number?.inSurah}");
  // print((penampunganAyat[0]["ayat"] as Verse).text?.arab);
  // print("END");
  // print(
  //     "Ayat : ${(penampunganAyat[penampunganAyat.length - 1]["ayat"] as Verse).number?.inSurah}");
  // print((penampunganAyat[penampunganAyat.length - 1]["ayat"] as Verse)
  //     .text
  //     ?.arab);
  // allJuz.add({
  //   "juz": juz,
  //   "start": penampunganAyat[0],
  //   "end": penampunganAyat[penampunganAyat.length - 1],
  //   "verse": penampunganAyat,
  // });
}
