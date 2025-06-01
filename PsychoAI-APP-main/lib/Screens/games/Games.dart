import 'package:flutter/material.dart';
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/Screens/draowing/DrawingBoardScreen.dart';
import 'package:psychoai/Screens/games/MazeGame.dart';
import 'package:psychoai/Screens/games/TicTakGame.dart';
import 'package:psychoai/common/db_functions.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
    final GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();
final List<Game> games = [
    Game(
      title: "Drawing",
      description: "An exciting adventure of drawing.",
      imageUrl: "https://via.placeholder.com/150",
            page:DrawingBoardScreen(title: '',),

    ),
    Game(
      title: "Tic Tac Toe",
      description: "A strategic tic tac toe game.",
      imageUrl: "https://via.placeholder.com/150",
            page:TicTacToeApp(),

    ),
    Game(
      title: "Maze",
      description: "A strategic maze game.",
      imageUrl: "https://via.placeholder.com/150",
      page:MazeApp(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Adjust size if needed
        child: CustomAppBar(key: _appBarKey), // Assign GlobalKey to the AppBar
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.pushReplacement(
                context,  MaterialPageRoute(
                  builder: (context){
                        DBFunctions.instance.updateUserInPoints(DBFunctions.instance.logedInUser, 10);
                        return games[index].page;
                      } 
                ) 
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.network(
                        games[index].imageUrl,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              games[index].title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(games[index].description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class Game {
  final String title;
  final String description;
  final String imageUrl;
  final Widget page;

  Game({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.page
  });
}