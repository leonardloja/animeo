import 'package:animeo/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'anime_details_screen.dart';

class SeeAllScreen extends StatelessWidget {
  SeeAllScreen({Key? key}) : super(key: key);

  final homeController = Get.find<HomeController>();
  var animeType = Get.arguments;

  List<dynamic>? results = [];

  @override
  Widget build(BuildContext context) {
    if (animeType[0]['animeType'] == 'Popular Anime') {
      results = homeController.popularAnime!.value;
    } else {
      results = homeController.recentReleaseAnime!.value;
    }
    return Obx(() {
      if (homeController.showLoading.value) {
        return const SafeArea(
          child: SafeArea(
            child: Scaffold(
              body: Center(child: SpinKitSpinningLines(color: Color(0xFF4098D7))),
            ),
          ),
        );
      } else {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                animeType[0]['animeType'] == 'Popular Anime'
                    ? 'Popular Anime'
                    : 'Recent Release',
                style: GoogleFonts.urbanist()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
            ),
            body: GridView.builder(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 12, bottom: 65),
              shrinkWrap: true,
              itemCount: results!.length,
              physics: const ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:
                    ((((MediaQuery.of(context).size.width) - 60) / 2) / 270),
                // mainAxisSpacing: 6,
                crossAxisSpacing: 14,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => AnimeDetailsScreen(),
                        arguments: [
                          {'animeID': results![index].animeId}
                        ],
                        transition: Transition.rightToLeft);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // width: 150,
                        height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey,
                          image: DecorationImage(
                            image: NetworkImage(results![index].animeImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        results![index].animeTitle,
                        style: GoogleFonts.urbanist().copyWith(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    });
  }
}
