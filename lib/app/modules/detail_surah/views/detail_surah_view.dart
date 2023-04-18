import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../constant/color.dart';
import 'package:get/get.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: Icon(
        //         Icons.arrow_back,
        //         size: 30,
        //         color: controller.isDark.isTrue ? appWhite : appPurpleDark,
        //       ),
        //     )),
        title: Text(
          ' Surah',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<detail.DetailSurah>(
        future: controller.getDetailSurah(Get.arguments["number"].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("Tidak ada data."),
            );
          }
          if (Get.arguments['bookmark'] != null) {
            bookmark = Get.arguments['bookmark'];
            print("INDEX AYAT : ${bookmark!["index_ayat"]}");
            print("GO TO INDEX AUTO SCROLL : ${bookmark!["index_ayat"] + 2}");
            controller.scrollC.scrollToIndex(bookmark!["index_ayat"] + 2,
                preferPosition: AutoScrollPosition.begin);
          }
          // print(bookmark);

          detail.DetailSurah surah = snapshot.data!;

          List<Widget> allAyat =
              List.generate(snapshot.data?.verses?.length ?? 0, (index) {
            detail.Verse? ayat = snapshot.data?.verses?[index];
            return AutoScrollTag(
              key: ValueKey(index + 2),
              index: index + 2,
              controller: controller.scrollC,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: appPurpleLight2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Get.isDarkMode
                                    ? "assets/logo/octagonal2.png"
                                    : "assets/logo/octagonal.png"),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${ayat?.number?.inSurah}",
                              ),
                            ),
                          ),
                          GetBuilder<DetailSurahController>(builder: (c) {
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: "Bookmark",
                                        middleText: "pilih jenis bookmark",
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await c.addBookmark(true,
                                                  snapshot.data!, ayat!, index);
                                              homeC.update();
                                            },
                                            child: Text("Terakhir Dibaca"),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: appPurpleDark),
                                          ),
                                          ElevatedButton(
                                            onPressed: () => c.addBookmark(
                                                false,
                                                snapshot.data!,
                                                ayat!,
                                                index),
                                            child: Text("Bookmark"),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: appPurpleDark),
                                          ),
                                        ]);
                                  },
                                  icon: Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 30,
                                  ),
                                ),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: Icon(
                                //     Icons.play_arrow,
                                //     size: 30,
                                //   ),
                                // ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ayat!.text?.arab}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Quran-Regular',
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ayat.text?.transliteration?.en}",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ayat.translation?.id}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          });

          return ListView(
            controller: controller.scrollC,
            padding: EdgeInsets.all(20),
            children: [
              AutoScrollTag(
                key: ValueKey(0),
                index: 0,
                controller: controller.scrollC,
                child: GestureDetector(
                  onTap: () => Get.defaultDialog(
                    backgroundColor: Get.isDarkMode
                        ? appPurpleDark.withOpacity(0.9)
                        : appGrey[100],
                    contentPadding: EdgeInsets.all(20),
                    title:
                        "Tafsir ${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}",
                    titleStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    content: Container(
                      child: Text(
                        "${surah.tafsir?.id ?? 'Tidak ada tafsir pada surah ini'}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    titlePadding: EdgeInsets.only(top: 10, bottom: 10),
                    middleTextStyle: TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        fontFamily: "poppins"),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: appOrange
                        // gradient:
                        //     LinearGradient(
                        //       colors: [appPurpleDark, appWhite]),
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: appWhite),
                          ),
                          Text(
                            "( ${surah.name?.translation?.id?.toUpperCase() ?? 'Error...'} )",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: appWhite),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error...'}",
                            style: TextStyle(fontSize: 15, color: appWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AutoScrollTag(
                index: 1,
                key: ValueKey(1),
                controller: controller.scrollC,
                child: SizedBox(
                  height: 20,
                ),
              ),
              ...allAyat,
            ],
          );
        },
      ),
    );
  }
}
