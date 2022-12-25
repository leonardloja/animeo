import 'package:animeo/controllers/my_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'anime_details_screen.dart';

class MyListScreen extends StatelessWidget {
  MyListScreen({Key? key}) : super(key: key);

  final myListController = Get.find<MyListController>();

  @override
  Widget build(BuildContext context) {
    myListController.loadMyListsFromDatabase();
    return Obx(() {
      if (myListController.list.value.isNotEmpty) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 38,
                            width: 38,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Text(
                            'My List',
                            style: GoogleFonts.urbanist().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  // TODO: GridView Builder
                  GridView.builder(
                    // padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    itemCount: myListController.list.value.length,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          ((((MediaQuery.of(context).size.width) - 60) / 2) /
                              270),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 14,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => AnimeDetailsScreen(),
                              arguments: [
                                {
                                  'animeID':
                                      myListController.list[index].id.toString()
                                }
                              ],
                              transition: Transition.rightToLeft);
                        },
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // width: 160,
                              height: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey,
                                image: DecorationImage(
                                  image: NetworkImage(myListController
                                      .list.value[index].imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              style:
                                  GoogleFonts.urbanist().copyWith(fontSize: 15),
                              myListController.list.value[index].name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // const Gap(130),
                ],
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 38,
                            width: 38,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Text(
                            'My List',
                            style: GoogleFonts.urbanist().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(110),
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                          // color: Colors.blue,
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/my_list_default.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gap(35),
                      Text(
                        'Your List is Empty',
                        style: GoogleFonts.urbanist().copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4098D7),
                        ),
                      ),
                      const Gap(20),
                      Text(
                        'It seems  that you haven\'t added \nany anime on to the list',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist().copyWith(
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
