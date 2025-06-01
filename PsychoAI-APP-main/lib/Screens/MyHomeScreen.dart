
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:psychoai/Screens/Home/imageUploader.dart';
// import 'package:psychoai/main.dart';
// import 'package:sizer/sizer.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 10.h,
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Container(
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     width: 23.w,
//                     child: Row(
//                       children: [
//                         Container(width: 10.w,height: 5.h, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.white,),),
//                           Spacer(),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("username", style:TextStyle(color: Colors.white, fontSize: 2.5.w),),
//                             Text("user role", style: TextStyle(color: Colors.white, fontSize: 2.5.w),),
//                             Text("status", style: TextStyle(color: Colors.white, fontSize: 2.5.w),),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Column(
//                 children: [
//                   Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 5.w),),
//                 ],
//               ),
//               Spacer(),
//               Column(
//                 children: [
//                   Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 5.w),),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Center(
//             // Center is a layout widget. It takes a single child and positions it
//             // in the middle of the parent.
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                  Row(
//                    children: [

//                      Text(
//                       'You have pushed the button this many times:',
//                                      ),
//                    ],
//                  ),
//                 Text(
//                   '$_counter',
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                      Navigator.pushReplacement(
//                         context, 
//                         MaterialPageRoute(builder: (context) => ImageUploadScreen()),
//                       );
//                   }, child:  Text('Upload Image'),
//                 )
//               ],
//             ),
//           ),
//           Spacer(),
//           Stack(
//             children: [
            
//           Positioned.fill(
//             child: Container(
//               padding: EdgeInsets.fromLTRB(0,10.0,0,0),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only( topLeft :Radius.circular(20), topRight:Radius.circular(20)),
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromRGBO(5, 1, 230, 0.8),
//                     Colors.transparent,
//                     Colors.transparent,
//                     Color.fromRGBO(5, 1, 230, 0.8)
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   stops: [0, 0, 0.1, 0.35],
//                 ),
//               ),
//             ),),
//               Container(
                
//                 height: 8.h,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Container(

//                       width: 20.w,
//                       child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.center,

//                         children: [
//                           Container(
//                             height: 8.h,

//                             child:
//                              Center(
//                               child: 
//                               Text("Analyzer", style: TextStyle(
//                                 fontSize: 5.w,
//                                 color: Colors.white
                                
//                               ),)
//                               )
//                               ),        
//                         ],
//                       ),
//                     ),
//                     Container(height: 6.h,child: VerticalDivider()),
//                     Container(

//                       width: 20.w,
//                       child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.center,

//                         children: [
//                           Container(
//                                           height: 8.h,

//                             child:
//                              Center(
//                               child: 
//                               Text("Games", style: TextStyle(
//                                 fontSize: 5.w,
//                                 color: Colors.white
                                
//                               ),)
//                               )
//                               ),        
//                         ],
//                       ),
//                     ),
//                     Container(height: 6.h,child: VerticalDivider()),
//                     Container(
//                                       height: 8.h,

//                       width: 20.w,
//                       child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.center,

//                         children: [
//                           Container(
//                                           height: 8.h,

//                             child:
//                              Center(
//                               child: 
//                               Text("Reports", style: TextStyle(
//                                 fontSize: 5.w,
//                                 color: Colors.white
                                
//                               ),)
//                               )
//                               ),                        ],
//                       ),
//                     ),
//                     Container(height: 6.h,child: VerticalDivider()),
//                     Container(
                      
//                       width: 20.w,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,

//                         children: [
//                           Container(
//                                                                 height: 8.h,

//                             child:
//                              Center(
//                               child: 
//                               Text("profile", style: TextStyle(
//                                 fontSize: 5.w,
//                                 color: Colors.white
//                               ),)
//                               )
//                               ),                        ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
     
//     );
//   }
// }