import 'package:flutter/material.dart';
import 'package:movies/ui/tabs/explore_tab/explore_tab.dart';
import 'package:movies/ui/tabs/home_tab/home_tab.dart';
import 'package:movies/ui/tabs/profile_tab/profile_tab.dart';
import 'package:movies/ui/tabs/search_tab/search_tab.dart';




class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF121312),
        body: tabs[currentIndex],
      
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF282A28),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildNavItem(Icons.home_outlined, 0),
                buildNavItem(Icons.search, 1),
                buildNavItem(Icons.explore, 2),
                buildNavItem(Icons.account_circle_outlined, 3),
              ],

            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        size: 32,
        color: currentIndex == index ? Color(0xFFF6BD00) : Colors.white,
      ),
      onPressed: () {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    ExploreTab(),
    ProfileTab(),
  ];
}
