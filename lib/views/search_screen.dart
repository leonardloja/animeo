import 'dart:math';

import 'package:animeo/controllers/search_controller.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_dropdown.dart';
import 'anime_details_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = Get.put(SearchController());

  static const String prefSearchKey = 'previousSearches';
  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();
    getPreviousSearches();
    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore &&
            currentEndPosition < currentCount &&
            !loading &&
            !inErrorState) {
          setState(() {
            loading = true;
            currentStartPosition = currentEndPosition;
            currentEndPosition =
                min(currentStartPosition + pageCount, currentCount);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);
      if (searches != null) {
        previousSearches = searches;
      } else {
        previousSearches = <String>[];
      }
    }
  }

  void startSearch(String value) {
    setState(() {
      searchController.fetchSearchAnime(value);
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();
      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // const Gap(5),
          Container(
            margin:
                const EdgeInsets.only(right: 10, left: 10, top: 15, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchTextController,
                    style: GoogleFonts.urbanist().copyWith(fontSize: 18),
                    cursorColor: const Color(0xFF4098D7),
                    onFieldSubmitted: (value) {
                      startSearch(searchTextController.text);
                    },
                    decoration: InputDecoration(
                      hintText: "Search your anime ...",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF4098D7),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF4098D7),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF4098D7),
                          width: 1.0,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF4098D7).withOpacity(0.08),
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_search_regular,
                        size: 20,
                        color: Color(0xFF4098D7),
                      ),
                      isDense: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blueGrey,
                  ),
                  onSelected: (String value) {
                    searchTextController.text = value;
                    startSearch(searchTextController.text);
                  },
                  itemBuilder: (BuildContext context) {
                    return previousSearches
                        .map<CustomDropdownMenuItem<String>>((String value) {
                      return CustomDropdownMenuItem<String>(
                        text: value,
                        value: value,
                        callback: () {
                          setState(() {
                            previousSearches.remove(value);
                            savePreviousSearches();
                            Navigator.pop(context);
                          });
                        },
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
          // NOTE: body layout
          GetBuilder<SearchController>(
            builder: (_) => searchController.showLoading
                ? Column(
                    children: const [
                      Gap(250),
                      Center(
                          child:
                              SpinKitSpinningLines(color: Color(0xFF4098D7))),
                    ],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    itemCount:
                        searchController.searchAnimeResults!.value.length,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          ((((MediaQuery.of(context).size.width) - 60) / 2) /
                              270),
                      // mainAxisSpacing: 6,
                      crossAxisSpacing: 14,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => AnimeDetailsScreen(),
                              arguments: [
                                {
                                  'animeID': searchController
                                      .searchAnimeResults![index].animeId
                                      .toString()
                                }
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
                                  image: NetworkImage(searchController
                                      .searchAnimeResults!
                                      .value[index]
                                      .animeImg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              style:
                                  GoogleFonts.urbanist().copyWith(fontSize: 15),
                              searchController
                                  .searchAnimeResults!.value[index].animeTitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          )
          // const Gap(50),
        ],
      ),
    );
  }
}
