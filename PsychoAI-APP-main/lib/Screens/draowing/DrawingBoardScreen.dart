import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/Screens/Home/HomePageScreen.dart';
import 'package:psychoai/common/db_functions.dart';
import 'package:psychoai/main.dart';
import 'package:sizer/sizer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class DrawingBoardScreen extends StatefulWidget {
  const DrawingBoardScreen({super.key, required this.title});

  final String title;

  @override
  State<DrawingBoardScreen> createState() => _DrawingBoardScreenState();
}

class _DrawingBoardScreenState extends State<DrawingBoardScreen>    with SingleTickerProviderStateMixin {
  bool image_saved=false;
  String analyzedData = "";

final DrawingController _drawingController = DrawingController();
/// Get drawing board data
Future<void> _getImageData() async {
  // Get the image data (byte array)
  final imageData = (await _drawingController.getImageData())?.buffer.asUint8List();
  
  if (imageData != null) {
    // Get the directory to save the file
    final directory = (await getExternalStorageDirectories())?[1];
    
    // Create the file path (e.g., 'image.png' in the documents directory)
    final filePath = '${directory!.path}/image.png';
    
    // Write the image data to the file
    final file = File(filePath);
    await file.writeAsBytes(imageData);
    
    print('Image saved to: $filePath');
    image_saved =true;
    await _sendImage(filePath);
     showDialog(
                                  context: context,
                                  builder: (BuildContext context) {

                                    return AlertDialog(
                                      title: Text('10 points for grevendor.'),
                                      content: Text(analyzedData),
                                      actions: [
                                        analyzedData == ""?
                                        Text("loading")
                                        :
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageScreen(title: '',)));
                                          },
                                          child: Text('Exit'),
                                        )
                                        ,
                                      ],
                                    );
                                  },
                                 );
                
  } else {
    image_saved = false;
    print('Failed to retrieve image data');
  }
  
  
}


  // Method to send image to server (replace `url` with your server endpoint)
  Future<void> _sendImage(filePath) async {

    
        
    if (image_saved == false) return;

    DBFunctions.instance.updateUserInPoints(DBFunctions.instance.logedInUser, -30);

    String url = 'http://192.168.33.7:5000/upload'; // Replace with your server's IP and port
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filePath));
    request.fields['userid'] = DBFunctions.instance.logedInUser!.id;
    
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        print('Server response: ${responseData.body}');
        Map<String, dynamic> parsedData = jsonDecode(responseData.body);
        
        // Update the analyzedData and trigger a UI rebuild
        setState(() {
          analyzedData = parsedData["response"]["choices"][0]["message"]["content"];
        });
      } else {
        print('Image upload failed! error ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while sending the image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
        final GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();

        return
        
Scaffold(

      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Adjust size if needed
        child: CustomAppBar(key: _appBarKey, ), // Assign GlobalKey to the AppBar
      ),
  body: Column(
    children: [
      Container(
        height: 78.h,
        child: DrawingBoard(
              controller: _drawingController,
              background: Container(width: 100.w, height: 70.h, color: Colors.white),
              showDefaultActions: true, /// Enable default action options
              showDefaultTools: true,   /// Enable default toolbar
            ),
            
      ),
      SizedBox(height: 8,),
      Center(
        child: ElevatedButton(onPressed: (){
        _getImageData();
        }, child: 
        Container(child: Column(
          children: [
            Text("Analyze"),
            FaIcon(FontAwesomeIcons.faceGrinTongue),
          ],
        ))
        ),
      )
    ],
  ),
);
         }

}