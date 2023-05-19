import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_habit/provider/HabitScreen/newHabitModel.dart';
import 'package:tracker_habit/provider/themeProvider.dart';
import 'package:tracker_habit/screen/Goal/goalScreens.dart';
import 'package:tracker_habit/screen/createAchievement.dart';
import 'package:tracker_habit/screen/fetchData.dart';
import 'package:tracker_habit/screen/habit/habitAllScreens.dart';
import 'package:tracker_habit/screen/habit/habitScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'homePage Screens/home.dart';
import 'settings/setting.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          Home(),
          Text('Stats'),
          Setting(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart), label: "Stats"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        onTap: (index) {
          _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
      ),
    );
  }
}