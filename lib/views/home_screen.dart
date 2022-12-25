import 'package:animeo/controllers/home_controller.dart';
import 'package:animeo/views/see_all_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:animeo/views/anime_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());
  PageController? pageViewController;

  Future<void> _loadData() async {
    homeController.onInit();
  }

  @override
  Widget build(BuildContext context) {
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
            body: RefreshIndicator(
              onRefresh: _loadData,
              child: ListView(
                children: [
                  // NOTE: Top Part
                  SizedBox(
                    // width: double.infinity,
                    height: 450,
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => AnimeDetailsScreen(),
                                    arguments: [
                                      {
                                        'animeID': homeController
                                            .topAiringAnime![0].animeId
                                            .toString()
                                      }
                                    ],
                                    transition: Transition.rightToLeft);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                // height: 500,
                                child: Obx(
                                  () => Stack(
                                    children: [
                                      Image.network(
                                        homeController
                                            .topAiringAnime![0].animeImg,
                                        width: double.infinity,
                                        height: 500,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 450,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Color(0xFF181A20)
                                            ],
                                            stops: [0, 1],
                                            begin: AlignmentDirectional(0, -1),
                                            end: AlignmentDirectional(0, 1),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0.9),
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00101213),
                                          ),
                                          alignment: const AlignmentDirectional(
                                              -0.15, 0.5),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  homeController
                                                      .topAiringAnime![0]
                                                      .animeTitle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.urbanist()
                                                      .copyWith(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  homeController
                                                      .topAiringAnime![0]
                                                      .latestEp,
                                                  style: GoogleFonts.urbanist()
                                                      .copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                const Gap(5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => AnimeDetailsScreen(),
                                    arguments: [
                                      {
                                        'animeID': homeController
                                            .topAiringAnime![1].animeId
                                            .toString()
                                      }
                                    ],
                                    transition: Transition.rightToLeft);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                // height: 500,
                                child: Obx(
                                  () => Stack(
                                    children: [
                                      Image.network(
                                        homeController
                                            .topAiringAnime![1].animeImg,
                                        width: double.infinity,
                                        height: 500,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 450,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Color(0xFF181A20)
                                            ],
                                            stops: [0, 1],
                                            begin: AlignmentDirectional(0, -1),
                                            end: AlignmentDirectional(0, 1),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0.92),
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00101213),
                                          ),
                                          alignment: const AlignmentDirectional(
                                             -0.98, 0.5),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  homeController
                                                      .topAiringAnime![1]
                                                      .animeTitle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.urbanist()
                                                      .copyWith(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  homeController
                                                      .topAiringAnime![1]
                                                      .latestEp,
                                                  style: GoogleFonts.urbanist()
                                                      .copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                const Gap(5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => AnimeDetailsScreen(),
                                    arguments: [
                                      {
                                        'animeID': homeController
                                            .topAiringAnime![2].animeId
                                            .toString()
                                      }
                                    ],
                                    transition: Transition.rightToLeft);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                // height: 500,
                                child: Obx(
                                  () => Stack(
                                    children: [
                                      Image.network(
                                        homeController
                                            .topAiringAnime![2].animeImg,
                                        width: double.infinity,
                                        height: 500,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 450,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Color(0xFF181A20)
                                            ],
                                            stops: [0, 1],
                                            begin: AlignmentDirectional(0, -1),
                                            end: AlignmentDirectional(0, 1),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0.92),
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00101213),
                                          ),
                                          alignment: const AlignmentDirectional(
                                              -0.98, 0.5),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  homeController
                                                      .topAiringAnime![2]
                                                      .animeTitle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.urbanist()
                                                      .copyWith(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  homeController
                                                      .topAiringAnime![2]
                                                      .latestEp,
                                                  style: GoogleFonts.urbanist()
                                                      .copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                const Gap(5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: const AlignmentDirectional(-0.85, 1),
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: SmoothPageIndicator(
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 3,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) {
                                pageViewController!.animateToPage(
                                  i,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              effect: const ExpandingDotsEffect(
                                expansionFactor: 2,
                                spacing: 8,
                                radius: 16,
                                dotWidth: 16,
                                dotHeight: 8,
                                dotColor: Color(0xFF9E9E9E),
                                activeDotColor: Color(0xFF4098D7),
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  // NOTE: Popular List
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Popular Anime',
                          style: GoogleFonts.urbanist().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => SeeAllScreen(),
                                arguments: [
                                  {'animeType': 'Popular Anime'}
                                ],
                                transition: Transition.rightToLeft);
                          },
                          child: Text(
                            'See All',
                            style: GoogleFonts.urbanist().copyWith(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    height: 250,
                    child: ListView.separated(
                      itemCount: (homeController.popularAnime!.length ~/ 4),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => AnimeDetailsScreen(),
                                arguments: [
                                  {
                                    'animeID': homeController
                                        .popularAnime![index].animeId
                                        .toString()
                                  }
                                ],
                                transition: Transition.rightToLeft);
                          },
                          // TODO: Fix layout for single anime card
                          // TODO: Check last code for layout
                          child: SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // width: double.infinity,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(homeController
                                          .popularAnime![index].animeImg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  homeController
                                      .popularAnime![index].animeTitle,
                                  maxLines: 2,
                                  // TODO: Duplicate for New Episode Releases Component
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.urbanist().copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(20);
                      },
                    ),
                  ),
                  const Gap(5),
                  // NOTE: New Episode Part
                  // TODO: Change to Recently Added and Display latest episodeNum
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Recent Release',
                          style: GoogleFonts.urbanist().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => SeeAllScreen(),
                                arguments: [
                                  {'animeType': 'Recent Release'}
                                ],
                                transition: Transition.rightToLeft);
                          },
                          child: Text(
                            'See All',
                            style: GoogleFonts.urbanist().copyWith(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    height: 250,
                    child: ListView.separated(
                      itemCount:
                          (homeController.recentReleaseAnime!.length ~/ 4),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => AnimeDetailsScreen(),
                                arguments: [
                                  {
                                    'animeID': homeController
                                        .recentReleaseAnime![index].animeId
                                        .toString()
                                  }
                                ],
                                transition: Transition.rightToLeft);
                          },
                          // TODO: Fix layout for single anime card
                          // TODO: Check last code for layout
                          child: SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // width: double.infinity,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(homeController
                                          .recentReleaseAnime![index].animeImg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  homeController
                                      .recentReleaseAnime![index].animeTitle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.urbanist().copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(20);
                      },
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
