import 'package:animeo/controllers/anime_details_controller.dart';
import 'package:animeo/controllers/my_list_controller.dart';
import 'package:animeo/models/my_list.dart';
import 'package:animeo/views/video_player_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../controllers/video_player_controller.dart';
import '../models/anime_details.dart';

class AnimeDetailsScreen extends StatelessWidget {
  AnimeDetailsScreen({Key? key}) : super(key: key);

  final animeDetailsController = Get.put(AnimeDetailsController());

  final myListController = Get.find<MyListController>();

  var animeID = Get.arguments;

  void openBottomSheet(List<EpisodesList> episodesList) {
    Get.bottomSheet(
      GridView.builder(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        itemCount: episodesList.length,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          // TODO: Gesture Detecter functionality
          return GestureDetector(
            onTap: () {
              final videoPlayerController = Get.put(VideoPlayerController());
              videoPlayerController.fetchStreamingLink(animeDetailsController
                  .animeDetails!.value.episodesList[index].episodeId
                  .toString());

              Get.to(() => VideoPlayerScreen(),
                  arguments: [
                    {
                      'episodeID': animeDetailsController
                          .animeDetails!.value.episodesList[index].episodeId
                          .toString(),
                      'episodeNum': animeDetailsController
                          .animeDetails!.value.episodesList[index].episodeNum
                          .toString(),
                    }
                  ],
                  transition: Transition.rightToLeft);
              // print(
              //     'EpisodeID----------------------------------------');
              // print(animeDetailsConroller.animeDetails!
              //     .value.episodesList[index].episodeId);
            },
            child: Container(
              // width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0XFF4098D7)),
              child: Center(child: Text(episodesList[index].episodeNum)),
            ),
          );
        },
      ),
      backgroundColor: Color(0xFF1F222A),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // NOTE: Fetch Anime Details
      animeDetailsController.fetchAnimeDetails(animeID[0]['animeID']);
      if (animeDetailsController.showLoading.value) {
        return const SafeArea(
          child: Scaffold(
            body: Center(child: SpinKitSpinningLines(color: Color(0xFF4098D7))),
          ),
        );
      } else {
        // animeDetailsConroller.showLoading.value = false;
        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                'Animeo',
                style: GoogleFonts.urbanist()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Obx(
                () => ListView(
                  children: [
                    // NOTE: TOP Part
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(animeDetailsController
                                      .animeDetails!.value.animeImg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Gap(14),
                            Expanded(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    animeDetailsController
                                        .animeDetails!.value.animeTitle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: GoogleFonts.urbanist().copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(5),
                                  Text(
                                    animeDetailsController
                                        .animeDetails!.value.releasedDate,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.urbanist().copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Gap(5),
                                  Text(
                                    'Status: ${animeDetailsController.animeDetails!.value.status}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.urbanist().copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Gap(14),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Icon(
                                      //   Icons.bookmark_add_outlined,
                                      //   size: 30,
                                      // ),
                                      // const Gap(10),
                                      // Text('My List'),
                                      Obx(() {
                                        // TODO: Remove idList since were not using it
                                        bool inList = false;
                                        myListController.list.value
                                            .forEach((element) {
                                          if (element.id ==
                                              animeID[0]['animeID']
                                                  .toString()) {
                                            inList = true;
                                          }
                                        });
                                        return ElevatedButton.icon(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  side: const BorderSide(
                                                    color: Color(0xFF4098D7),
                                                  ),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(inList
                                                          ? Colors.transparent
                                                          : Color(0xFF4098D7))),
                                          onPressed: () {
                                            final item = MyList(
                                                id: animeID[0]['animeID']
                                                    .toString(),
                                                name: animeDetailsController
                                                    .animeDetails!
                                                    .value
                                                    .animeTitle,
                                                releasedDate:
                                                    animeDetailsController
                                                        .animeDetails!
                                                        .value
                                                        .releasedDate,
                                                imageUrl: animeDetailsController
                                                    .animeDetails!
                                                    .value
                                                    .animeImg);
                                            if (inList) {
                                              myListController
                                                  .removeFromMyList(item);
                                              //Removed
                                              Get.snackbar(
                                                  animeDetailsController
                                                      .animeDetails!
                                                      .value
                                                      .animeTitle,
                                                  'Removed from My List successfully!',
                                                  backgroundColor:
                                                      Colors.black38,
                                                  duration: const Duration(
                                                      milliseconds: 1200),
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                            } else {
                                              myListController
                                                  .addToMyList(item);
                                              //Add
                                              Get.snackbar(
                                                  animeDetailsController
                                                      .animeDetails!
                                                      .value
                                                      .animeTitle,
                                                  'Added to My List successfully!',
                                                  backgroundColor:
                                                      Colors.black38,
                                                  duration: const Duration(
                                                      milliseconds: 1200),
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                            }
                                          },
                                          icon: inList
                                              ? Text(
                                                  String.fromCharCode(
                                                      FluentSystemIcons
                                                          .ic_fluent_checkmark_regular
                                                          .codePoint),
                                                  style: TextStyle(
                                                    inherit: false,
                                                    color:
                                                        const Color(0xFF4098D7),
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: FluentSystemIcons
                                                        .ic_fluent_checkmark_regular
                                                        .fontFamily,
                                                    package: FluentSystemIcons
                                                        .ic_fluent_add_regular
                                                        .fontPackage,
                                                  ),
                                                )
                                              : Text(
                                                  String.fromCharCode(
                                                      FluentSystemIcons
                                                          .ic_fluent_add_regular
                                                          .codePoint),
                                                  style: TextStyle(
                                                    inherit: false,
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: FluentSystemIcons
                                                        .ic_fluent_add_regular
                                                        .fontFamily,
                                                    package: FluentSystemIcons
                                                        .ic_fluent_add_regular
                                                        .fontPackage,
                                                  ),
                                                ),
                                          label: Text(
                                            'My List',
                                            style: GoogleFonts.urbanist(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: inList
                                                    ? Color(0xFF4098D7)
                                                    : Colors.white),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(5),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      height: 30,
                      child: ListView.separated(
                        itemCount: (animeDetailsController
                            .animeDetails!.value.genres.length),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // width: double.infinity,
                                // height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: const Color(0xFF4098D7),
                                      width: 1.3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                      animeDetailsController
                                          .animeDetails!.value.genres[index],
                                      style: GoogleFonts.urbanist(
                                        fontSize: 13,
                                        color: const Color(0xFF4098D7),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Gap(10);
                        },
                      ),
                    ),
                    const Gap(14),
                    // NOTE: Synopsis Part
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      // TODO: Design text
                      child: ReadMoreText(
                        animeDetailsController.animeDetails!.value.synopsis,
                        trimLines: 5,
                        colorClickableText: Colors.amber,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: ' Show less',
                        style: GoogleFonts.urbanist(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        moreStyle: GoogleFonts.urbanist().copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        lessStyle: GoogleFonts.urbanist().copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Gap(15),
                    // NOTE: Episodes Part
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 25),
                      child: Row(
                        children: [
                          Text(
                            'Episodes',
                            style: GoogleFonts.urbanist().copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              openBottomSheet(animeDetailsController
                                  .animeDetails!.value.episodesList);
                            },
                            child: Text('More'),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      height: 250,
                      child: ListView.separated(
                        itemCount: animeDetailsController
                                    .animeDetails!.value.episodesList.length <
                                10
                            ? animeDetailsController
                                .animeDetails!.value.episodesList.length
                            : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 50,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // TODO: Design for Episode boxes
                                // TODO: Gesture Detector
                                GestureDetector(
                                  onTap: () {
                                    final videoPlayerController =
                                        Get.put(VideoPlayerController());
                                    videoPlayerController.fetchStreamingLink(
                                        animeDetailsController.animeDetails!
                                            .value.episodesList[index].episodeId
                                            .toString());

                                    Get.to(() => const VideoPlayerScreen(),
                                        arguments: [
                                          {
                                            'episodeID': animeDetailsController
                                                .animeDetails!
                                                .value
                                                .episodesList[index]
                                                .episodeId
                                                .toString(),
                                            'episodeNum': animeDetailsController
                                                .animeDetails!
                                                .value
                                                .episodesList[index]
                                                .episodeNum
                                                .toString(),
                                          }
                                        ],
                                        transition: Transition.rightToLeft);
                                    // print(
                                    //     'EpisodeID----------------------------------------');
                                    // print(animeDetailsConroller.animeDetails!
                                    //     .value.episodesList[index].episodeId);
                                  },
                                  child: Container(
                                    // width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0XFF4098D7)),
                                    child: Center(
                                        child: Text(animeDetailsController
                                            .animeDetails!
                                            .value
                                            .episodesList[index]
                                            .episodeNum)),
                                  ),
                                ),
                                const Gap(10),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Gap(15);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
