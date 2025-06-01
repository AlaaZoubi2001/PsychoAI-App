import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:psychoai/main.dart';
import 'package:sizer/sizer.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class SentimentsScreen extends StatefulWidget {
  const SentimentsScreen({super.key, required this.title});

  final String title;

  @override
  State<SentimentsScreen> createState() => _SentimentsScreenState();
}

class _SentimentsScreenState extends State<SentimentsScreen>    with SingleTickerProviderStateMixin {
ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/460x242"),
                        fit: BoxFit.fill,
                      ),
                    ),
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
                                  height: 8.h,
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
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/100x100"),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(48),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                              'progress',
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
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/100x100"),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(48),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/100x100"),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(48),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/100x100"),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(48),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                          itemCount: 7,
                          
                          itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.all(5),
                        
                            leading: InkWell(
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
                              child: Container(
                                  width: 87.w,
                                  height: 15.h,
                                  
                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            "https://via.placeholder.com/420x120"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(48),
                                                      ),
                                                    ),
                                ),
                            ),
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

}