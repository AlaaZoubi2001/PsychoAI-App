import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psychoai/Screens/Home/HomePageScreen.dart';
import 'package:psychoai/Screens/Profile.dart';
import 'package:psychoai/Screens/notifications.dart';
import 'package:psychoai/common/db_functions.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar>   with SingleTickerProviderStateMixin{
  int _tabIndex = 1;
  

  // Getter for _tabIndex
  int get tabIndex => _tabIndex;

  // Setter for _tabIndex
  set tabIndex(int v) {
    setState(() {
      _tabIndex = v;
    });
  }

  var titles = const [
    Text("Reports", style: TextStyle(color: Colors.white),),
    Text("Home", style: TextStyle(color: Colors.white),),
    Text("AI Analyzer", style: TextStyle(color: Colors.white),),
  ];
  bool _loaded_all = false;

    // Setter for _tabIndex
  set loaded_all(bool v) {
    setState(() {
      _loaded_all = v;
    });
  }
  int firstrun = 0;

  bool get loaded_all => _loaded_all;



@override
Widget build(BuildContext context) {
  bool isHomePage = ModalRoute.of(context)?.settings.name == 'HomePageScreen';
  var dbFunctions = Provider.of<DBFunctions>(context);

    if (loaded_all==false ||  dbFunctions.sentiments.isEmpty){
      dbFunctions.fetchUserSentiments();
      setState(() {
    loaded_all = true;
    });
    }

  // If sentiments are available, display the full AppBar
  return AppBar(
    toolbarHeight: 15.h,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    leading: isHomePage
        ? null // No back arrow on the home page
        : IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePageScreen(title: '',)),
              ); // Navigate back to the previous screen
            },
          ),
    title: dbFunctions.logedInUser != null 
        ? Container(

            width: 60.w,
            height: 15.h,
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 53.w,
                      height: 5.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titles[_tabIndex],
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hello  ',
                                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              ),
                              TextSpan(
                                text: dbFunctions.logedInUser!.name,
                                style: TextStyle(color: Color(0xFF0098FF), fontSize: 16.sp),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Points:  ',
                                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              ),
                              TextSpan(
                                text: dbFunctions.logedInUser!.points,
                                style: TextStyle(color: Color(0xFF0098FF), fontSize: 16.sp),
                              ),
                              TextSpan(
                                text: '        ',
                                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              ), 
                              TextSpan(
                                text: 'Status: ',
                                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              ), 
                              TextSpan(
                                text: dbFunctions.sentiments.isEmpty ? "Loading" : dbFunctions.sentiments.first["description"],
                                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              ), 
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.user,color: Colors.white,),
        tooltip: 'Open Profile',
        onPressed: () {
          Navigator.pushReplacement(
            context,  MaterialPageRoute(
              builder: (context)=>ProfilePage())
          );
        },
      ),
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.bell,color: Colors.white,),
        tooltip: 'Open notifications',
        onPressed: () {
          Navigator.pushReplacement(
            context,  MaterialPageRoute(
              builder: (context)=>NotificationsPage())
          );
        },
      ),
    ],
  );
}

}
