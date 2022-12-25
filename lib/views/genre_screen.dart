import 'package:animeo/controllers/genre_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/anime_by_genre.dart';
import 'anime_details_screen.dart';

class GenreScreen extends StatelessWidget {
  GenreScreen({Key? key}) : super(key: key);

  final genreController = Get.put(GenreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png',
                fit: BoxFit.cover, height: 38),
            const Gap(15),
            Text(
              'Genre',
              style: GoogleFonts.urbanist(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 6,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // NOTE: Tab title
                TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text(
                        'Action',
                        style: GoogleFonts.urbanist(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Adventure',
                        style: GoogleFonts.urbanist(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Comedy',
                        style: GoogleFonts.urbanist(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Fantasy',
                        style: GoogleFonts.urbanist(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Romance',
                        style: GoogleFonts.urbanist(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Sports',
                        style: GoogleFonts.urbanist(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // NOTE: Tab Content
          body: TabBarView(
            children: <Widget>[
              tabContent(context, 'action'),
              tabContent(context, 'adventure'),
              tabContent(context, 'comedy'),
              tabContent(context, 'fantasy'),
              tabContent(context, 'romance'),
              tabContent(context, 'sports'),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabContent(BuildContext context, String genre) {
    genreController.fetchAnimeByGenre(genre);
    List<AnimeByGenre>? results = <AnimeByGenre>[];

    return Obx(() {
      if (genre == 'action') {
        results = genreController.actionResults!.value;
      }
      if (genre == 'adventure') {
        results = genreController.adventureResults!.value;
      }
      if (genre == 'comedy') {
        results = genreController.comedyResults!.value;
      }

      if (genre == 'fantasy') {
        results = genreController.fantasyResults!.value;
      }

      if (genre == 'romance') {
        results = genreController.romanceResults!.value;
      }
      if (genre == 'sports') {
        results = genreController.sportsResults!.value;
      }
      if (genreController.showLoading.value) {
        return const SafeArea(
          child: SafeArea(
            child: Scaffold(
              body:
                  Center(child: SpinKitSpinningLines(color: Color(0xFF4098D7))),
            ),
          ),
        );
      } else {
        return Scaffold(
          body: GridView.builder(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 65),
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
        );
      }
    });
  }
}
