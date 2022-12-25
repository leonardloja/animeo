import 'package:animeo/views/genre_screen.dart';
import 'package:animeo/views/my_list_screen.dart';
import 'package:animeo/views/home_screen.dart';
import 'package:animeo/views/search_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[];
  static const String prefSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pageList.add(HomeScreen());
    pageList.add(SearchScreen());
    pageList.add(MyListScreen());
    pageList.add(GenreScreen());
    getCurrentIndex();
  }


  void saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefSelectedIndexKey, _selectedIndex);
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        final index = prefs.getInt(prefSelectedIndexKey);
        if (index != null) {
          _selectedIndex = index;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(child: pageList[_selectedIndex]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            // TODO: Add Blur effect
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              saveCurrentIndex();
            },
            backgroundColor: const Color(0xFF181A20).withOpacity(0.85),
            elevation: 0,
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF4098D7),
            unselectedItemColor: const Color(0xFF9E9E9E),
            selectedLabelStyle: GoogleFonts.urbanist().copyWith(
              fontSize: 11,
            ),
            unselectedLabelStyle: GoogleFonts.urbanist().copyWith(
              fontSize: 11,
            ),
            iconSize: 26,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_bookmark_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_bookmark_filled),
                label: 'My List',
              ),
              BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_text_grammar_options_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_text_grammar_options_filled),
                label: 'Genre',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
