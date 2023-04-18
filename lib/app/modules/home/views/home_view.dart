import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Al-Quran",
          style:
              TextStyle(color: controller.isDark.isTrue ? appWhite : appWhite),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => controller.changeThemeMode(),
              icon: Icon(Icons.color_lens_outlined,
                  size: 35,
                  color: controller.isDark.isTrue ? appWhite : appWhite),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<HomeController>(
                builder: (c) => FutureBuilder<Map<String, dynamic>?>(
                  future: c.getLastRead(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // gradient: LinearGradient(
                            //   colors: [
                            //     appGreen,
                            //     appOrange,
                            //   ],
                            // ),
                            color: appOrange),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -60,
                              right: -3,
                              child: Opacity(
                                opacity: 0.6,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: Image.asset(
                                    "assets/logo/alquran.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: appWhite,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Terakhir Dibaca",
                                        style: TextStyle(color: appWhite),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Loading...",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: appWhite),
                                  ),
                                  Text(
                                    "",
                                    style: TextStyle(color: appWhite),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }

                    Map<String, dynamic>? lastRead = snapshot.data;

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [appOrange, appGreen],
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onLongPress: () {
                            if (lastRead != null) {
                              Get.defaultDialog(
                                title: "Pesan",
                                middleText:
                                    "Apakah anda yakin ingin menghapus terakhir dibaca?",
                                actions: [
                                  OutlinedButton(
                                    onPressed: () => Get.back(),
                                    child: Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      c.deleteBookmark(lastRead['id']);
                                    },
                                    child: Text("Hapus"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: appPurpleDark),
                                  ),
                                ],
                              );
                            }
                          },
                          onTap: () {
                            if (lastRead != null) {
                              //bisa diarahkan ke page detail surah / juz
                              // print(lastRead);
                              switch (lastRead["via"]) {
                                case "juz":
                                  Map<String, dynamic> dataPerJuz =
                                      controller.allJuz[lastRead["juz"] - 1];
                                  Get.toNamed(
                                    Routes.DETAIL_JUZ,
                                    arguments: {
                                      "juz": dataPerJuz,
                                      "bookmark": lastRead
                                    },
                                  );
                                  break;
                                default:
                                  Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                    "name": lastRead['name']
                                        .toString()
                                        .replaceAll("+", "'"),
                                    "number": lastRead['number_surah'],
                                    "bookmark": lastRead,
                                  });
                              }
                            }
                          },
                          child: Container(
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -60,
                                  right: -3,
                                  child: Opacity(
                                    opacity: 0.6,
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      child: Image.asset(
                                        "assets/logo/alquran.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.menu_book_rounded,
                                            color: appWhite,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Terakhir Dibaca",
                                            style: TextStyle(color: appWhite),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        lastRead == null
                                            ? ""
                                            : "${lastRead['surah'].toString().replaceAll("+", "'")}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: appWhite),
                                      ),
                                      Text(
                                        lastRead == null
                                            ? "Belum ada data"
                                            : "Juz ${lastRead['juz']} | Ayat ${lastRead['ayat']}",
                                        style: TextStyle(color: appWhite),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              TabBar(
                labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoppinsRegular"),
                tabs: [
                  Tab(
                    text: "Surah",
                  ),
                  Tab(
                    text: "Juz",
                  ),
                  Tab(
                    text: "Bookmark",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        //jika tidak punya data
                        if (!snapshot.hasData) {
                          return Center(child: Text("Tidak Ada Data"));
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                    "name": surah.name!.transliteration!.id,
                                    "number": surah.number!,
                                  });
                                },
                                leading: Obx(() => Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(controller
                                                  .isDark.isTrue
                                              ? "assets/logo/octagonal2.png"
                                              : "assets/logo/octagonal.png"),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${surah.number}",
                                        ),
                                      ),
                                    )),
                                title: Text(
                                  "${surah.name?.transliteration?.id ?? 'Error...'}",
                                ),
                                subtitle: Text(
                                  "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error...'}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: appGrey,
                                  ),
                                ),
                                trailing: Text(
                                  "${surah.name?.short ?? 'Error...'}",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          controller.adaDataAllJuz.value = false;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        //jika tidak punya data
                        if (!snapshot.hasData) {
                          return Center(child: Text("Tidak Ada Data"));
                        }
                        controller.adaDataAllJuz.value = true;
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dataPerJuz =
                                snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAIL_JUZ,
                                  arguments: {"juz": dataPerJuz},
                                );
                              },
                              leading: Obx(() => Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            controller.isDark.isTrue
                                                ? "assets/logo/octagonal2.png"
                                                : "assets/logo/octagonal.png"),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                      ),
                                    ),
                                  )),
                              title: Text(
                                "Juz ${index + 1}",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(top: 15),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mulai dari ${(dataPerJuz['start']['surah'] as detail.DetailSurah).name?.transliteration?.id} ayat ${(dataPerJuz['start']['ayat'] as detail.Verse).number?.inSurah}",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  Text(
                                    "Sampai dengan ${(dataPerJuz['end']['surah'] as detail.DetailSurah).name?.transliteration?.id} ayat ${(dataPerJuz['end']['ayat'] as detail.Verse).number?.inSurah}",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (c) {
                        if (c.adaDataAllJuz.isFalse) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 10),
                                Text("Sedang menunggu data juz."),
                              ],
                            ),
                          );
                        } else {
                          return FutureBuilder<List<Map<String, dynamic>>>(
                            future: c.getBookmark(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.data?.length == 0) {
                                return Center(
                                  child: Text("Belum ada Bookmark"),
                                );
                              }

                              return ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                      snapshot.data![index];
                                  return ListTile(
                                    onTap: () {
                                      switch (data["via"]) {
                                        case "juz":
                                          print("GO TO JUZ");
                                          // print(data);
                                          Map<String, dynamic> dataPerJuz =
                                              controller
                                                  .allJuz[data["juz"] - 1];
                                          Get.toNamed(
                                            Routes.DETAIL_JUZ,
                                            arguments: {
                                              "juz": dataPerJuz,
                                              "bookmark": data
                                            },
                                          );
                                          break;
                                        default:
                                          Get.toNamed(Routes.DETAIL_SURAH,
                                              arguments: {
                                                "name": data['name']
                                                    .toString()
                                                    .replaceAll("+", "'"),
                                                "number": data['number_surah'],
                                                "bookmark": data,
                                              });
                                      }
                                    },
                                    leading: Obx(
                                      () => Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(controller
                                                    .isDark.isTrue
                                                ? "assets/logo/octagonal2.png"
                                                : "assets/logo/octagonal.png"),
                                          ),
                                        ),
                                        child:
                                            Center(child: Text("${index + 1}")),
                                      ),
                                    ),
                                    title: Text(
                                        "Judul ${data['surah'].toString().replaceAll("+", "'")}"),
                                    subtitle: Text(
                                      "Ayat ${data['ayat']} - via ${data['via']}",
                                      style: TextStyle(color: appGrey),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        c.deleteBookmark(data['id']);
                                      },
                                      icon: Icon(Icons.delete_outline),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.changeThemeMode(),
      //   // Get.isDarkMode
      //   //     ? Get.changeTheme(themeLight)
      //   //     : Get.changeTheme(themeDark);

      //   child: Obx(() => Icon(Icons.color_lens_rounded,
      //       size: 40,
      //       color: controller.isDark.isTrue ? appPurpleLight2 : appWhite)),
      // ),
    );
  }
}
