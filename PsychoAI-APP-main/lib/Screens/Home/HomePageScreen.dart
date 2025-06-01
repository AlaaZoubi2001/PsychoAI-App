import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/Screens/Home/Home.dart';
import 'package:psychoai/Screens/Home/imageUploader.dart';
import 'package:psychoai/Screens/reports/reports.dart';
import 'package:psychoai/common/db_functions.dart';
import 'package:sizer/sizer.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with SingleTickerProviderStateMixin {
  late PageController pageController;
  final GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();

  @override
  void initState() {
    super.initState();

    // Initialize the PageController with initialPage as 1
    pageController = PageController(initialPage: 1);

    // Access appBarKey after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_appBarKey.currentState != null) {
        print('Initial Tab Index: ${_appBarKey.currentState!.tabIndex}');
        // You can manipulate the tabIndex here if needed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var titles = const [
      Text("Reports"),
      Text("Home"),
      Text("AI Analyzer"),
    ];

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: CircleNavBar(
            activeIcons: const [
              Icon(Icons.person,size: 40,color: Colors.deepPurple),
              Icon(Icons.home, size: 40,color: Colors.deepPurple),
              FaIcon(FontAwesomeIcons.microchip, size: 38,color: Colors.deepPurple),
            ],
            inactiveIcons: titles,
            color: Colors.white,
            height: 40,
            circleWidth: 40,
            activeIndex: _appBarKey.currentState?.tabIndex ?? 1, // Safely access tabIndex
            onTap: (index) {
              // Safely update tabIndex and navigate pages
              if (_appBarKey.currentState != null) {
                _appBarKey.currentState!.tabIndex = index;
                pageController.jumpToPage(index);
              }
            },
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            cornerRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            shadowColor: Colors.deepPurple,
            elevation: 10,
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0), // Adjust size if needed
            child: CustomAppBar(key: _appBarKey), // Assign GlobalKey to the AppBar
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: (v) {
              // Safely update tabIndex based on the page view swipe
              if (_appBarKey.currentState != null) {
                setState(() {
                                  _appBarKey.currentState!.tabIndex = v;

                });
              }
            },
            children: [
              ReportsPage(),
              HomeScreen(title: '',),
              ImageUploadScreen(),
            ],
          ),
        );
      },
    );
  }
}
