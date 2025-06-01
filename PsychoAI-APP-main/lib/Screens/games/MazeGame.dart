import 'package:flutter/material.dart';
import 'package:maze/maze.dart';
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/Screens/Home/HomePageScreen.dart';

void main() => runApp(MazeApp());

class MazeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MazeScreen();
  }
}

class MazeScreen extends StatefulWidget {
  @override
  _MazeScreenState createState() => _MazeScreenState();
}

class _MazeScreenState extends State<MazeScreen> {
      final GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();
  int points = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Adjust size if needed
        child: CustomAppBar(key: _appBarKey), // Assign GlobalKey to the AppBar
      ),
        body: SafeArea(
            child: Maze(
                player: MazeItem(
                    'https://cdn-icons-png.flaticon.com/512/808/808433.png',
                    ImageType.network),
                columns: 6,
                rows: 12,
                wallThickness: 4.0,
                finish: MazeItem(
                    'https://cdn-icons-png.flaticon.com/512/808/808433.png',
                    ImageType.network),
                onFinish: () => 
                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                              points+=10;

                                    return AlertDialog(
                                      title: Text('10 points for grevendor.'),
                                      content: Text('Change this to move to a page.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageScreen(title: '',)));
                                          },
                                          child: Text('Exit'),
                                        ),
                                      ],
                                    );
                                  },
                                 )
                
                )));
  }
}