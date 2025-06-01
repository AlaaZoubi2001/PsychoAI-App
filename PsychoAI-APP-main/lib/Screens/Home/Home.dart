import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:psychoai/Screens/games/Games.dart';
import 'package:psychoai/Screens/MyHomeScreen.dart';
import 'package:psychoai/Screens/draowing/DrawingBoardScreen.dart';
import 'package:psychoai/Screens/SignUp.dart';
import 'package:psychoai/Screens/Home/syntements/SyntemintsScreen.dart';
import 'package:psychoai/common/db_functions.dart';
import 'package:psychoai/main.dart';
import 'package:sizer/sizer.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>    with SingleTickerProviderStateMixin {
ScrollController controller = ScrollController();
    var firstrun = 0;




  @override
  Widget build(BuildContext context) {
     var dbFunctions = Provider.of<DBFunctions>(context);
    if (firstrun==0){
      dbFunctions.fetchUserRecomendations();
      dbFunctions.fetchUserSentiments();
      setState(() {
        firstrun =1;
    });
    }
        return Container(
            width: 100.w,
            height: 80.h,
            decoration: ShapeDecoration(
              color: Color(0xFFFDFDFE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.09),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
              children: [
                 InkWell(
                              onTap: (){
                                 showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Move to next page.'),
                                      content: Text('Change this to move to a page.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: Text('Exit'),
                                        ),
                                      ],
                                    );
                                  },
                                 );
                              },
                   child:  Container(
                    width: 100.w,
                    height: 25.h,
                  child:Image.asset(
                    "assets/images/Beige Playful Illustrative Mental Health Tips Youtube Thumbnail.png",
                    fit: BoxFit.fill,),

                  ),
                ),
                SizedBox(height: 3.h,),
                Container(
                  width: 90.w,
                  height: 22.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        height: 3.h,
                        child: Text(
                          'Most Used',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                                                height: 3.h,

                        child: Text(
                          'Most Used Functions',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 16.h,
                        child:ListView(
                          scrollDirection: Axis.horizontal,
                          
                          children: [
                            // InkWell(
                            //   onTap: (){
                            //      showDialog(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return AlertDialog(
                            //           title: Text('Move to next page.'),
                            //           content: Text('Change this to move to a page.'),
                            //           actions: [
                            //             ElevatedButton(
                            //               onPressed: () {
                            //                 Navigator.of(context).pop(); // Close the dialog
                            //               },
                            //               child: Text('Exit'),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //      );
                            //   },
                            //   child:  Container(
                            //       width: 25.w,
                            //       height: 8.h,
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Container(
                            //           width: 100,
                            //           height: 100,
                            //           clipBehavior: Clip.antiAlias,
                            //           decoration: ShapeDecoration(
                                      
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(48),
                            //             ),
                            //           ),
                            //           child: Center(
                            //             child: 
                            //             FaIcon(FontAwesomeIcons.barsProgress, size: 38,color: Colors.deepPurple), ),
                            //         ),
                            //         const SizedBox(height: 8),
                            //         Container(
                            //           height: 20,
                            //           child: Column(
                            //             mainAxisSize: MainAxisSize.min,
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.start,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               SizedBox(
                            //                 width: 100,
                            //                 child: Text(
                            //                   'progress',
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                     color: Colors.black,
                            //                     fontSize: 14,
                            //                     fontFamily: 'Inter',
                            //                     fontWeight: FontWeight.w500,
                            //                     height: 0.10,
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 12),
                            InkWell(
                              onTap: (){
                                  Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => GamesScreen()),
                          );
                                 
                                 },
                              child: Container(
                                                                width: 25.w,
                                  height: 10.h,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(48),
                                        ),
                                      ),
                                     child: Center(
                                        child: 
                                        FaIcon(FontAwesomeIcons.gamepad, size: 38,color: Colors.deepPurple), ),
                                    ),
                                    Container(
                                      height: 20,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              'Games',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                height: 0.10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                             InkWell(
                              onTap: (){
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SyntimentsProgressPage()));
                              },
                              child:  Container(
                                                                width: 25.w,
                                  height: 10.h,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(48),
                                        ),
                                      ),
                                    child: Center(
                                        child: 
                                        FaIcon(FontAwesomeIcons.faceSmile, size: 38,color: Colors.deepPurple), ),
                                    ),
                                    Container(
                                      height: 20,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              'sentiments',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                height: 0.10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: (){
                                 showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Move to next page.'),
                                      content: Text('Change this to move to a page.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: Text('Exit'),
                                        ),
                                      ],
                                    );
                                  },
                                 );
                              },
                              child:  Container(
                              
                                  width: 25.w,
                                  height: 10.h,
                                 child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                       
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(48),
                                        ),
                                      ),
                                     child: Center(
                                        child: 
                                        FaIcon(FontAwesomeIcons.book, size: 38,color: Colors.deepPurple), ),
                                    ),
                                    Container(
                                      height: 20,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              'reports',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                height: 0.10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                Container(
                   width: 90.w,
                        height: 25.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                         Container(
                        height: 3.h,
                        child: Text(
                          'Recommended',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                                                height: 3.h,
                      
                        child: Text(
                          'Recomended actions in app.',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                           width: 90.w,
                        height: 18.h,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: dbFunctions.recommendations.length,
                          
                          itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.all(5),
                                                      
                                leading: InkWell(
                                  onTap: (){
                                    // Navigator.pushReplacement(
                                    //       context,
                                    //       MaterialPageRoute(builder: (context) => Recommended[index]["page"]!),
                                    //     ):
                                         debugPrint("here");
                                  },
                                  child: Container(
                                      width: 87.w,
                                      height: 15.h,
                                      
                                        decoration: ShapeDecoration(
                                                          // image: DecorationImage(
                                                          //   image: NetworkImage(
                                                          //       "https://via.placeholder.com/420x120"),
                                                          //   fit: BoxFit.fill,
                                                          // ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(48),
                                                          ),
                                                        ),
                                                        child: 
                                                        // index < Recommended.length ? Recommended[index]["text"]:
                                                        
                                                        Center(child: Container(
                                                          width: 87.w,
                                                          height: 15.h,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(width: 2.w,),
                                                               Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.fromLTRB(15,5,5,5,),
                                                                    height: 5.h,
                                                                    width: 10.w,                           
                                                                  decoration: ShapeDecoration(
                                                                                    // image: DecorationImage(
                                                                                    //   image: NetworkImage(
                                                                                    //       "https://via.placeholder.com/420x120"),
                                                                                    //   fit: BoxFit.fill,
                                                                                    // ),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(48),
                                                                                    ),
                                                                                   
                                                                                  ),
                                                                                  child: 
                                                                                  dbFunctions.recommendations[index]["type"]=="Post"?     
                                                                             FaIcon(FontAwesomeIcons.podcast, size: 38,color: Colors.deepPurple)
                                                                             :
                                                                             FaIcon(FontAwesomeIcons.play, size: 38,color: Colors.deepPurple)
                                                                             ,
                              
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(width:5.w),
                                                              // Spacer(flex: ,),
                                                              Column(
                                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 70.w,
                                                                    child: Text.rich(
                                                                      maxLines: null, // Allow as many lines as needed
                                                                      overflow: TextOverflow.visible, // Show all text, wrap if necessary
                                                                                      TextSpan(
                                                                                        children: [
                                                                                          TextSpan(
                                                                                            text: dbFunctions.recommendations[index]["description"].toString(),
                                                                                            style: TextStyle(color: Colors.black, fontSize: 14.sp),
                                                                                            
                                                                                          ),
                                                                                          TextSpan(
                                                                    
                                                                                             recognizer: TapGestureRecognizer()
                                                                                            ..onTap = () {
                                                                                              _launchURL(dbFunctions.recommendations[index]["link"]);
                                                                                              // TODO: Nav if you have a link:
                                                                                              // ---  if vedio open chrome
                                                                                              // --- if post opn chrome
                                                                                              //  
                                                                                              //  Navigator.pushReplacement(
                                                                                              //   context,
                                                                                              //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                                                                                              // );
                                                                    
                                                                                            },
                                                                                            text: ' see more',
                                                                                            style: TextStyle(
                                                                                              color: Color(0xFF0098FF), fontSize: 14.sp),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            Spacer(),
                                                            ],
                                                          ),
                                                        )),
                                                        
                                    ),
                                ),
                              ),
                              Divider()
                            ],
                          );   
                          },
                         
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
              )
            ));
  }




_launchURL(_url) async {
     final Uri url = Uri.parse(_url);
   if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
    }
}
}