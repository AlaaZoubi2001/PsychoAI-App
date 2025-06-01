import 'package:flutter/material.dart';
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:tic_tac_toe_game/tic_tac_toe_game.dart'; // Import the package


class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TicTacToeScreen();
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> _board = List.filled(9, ''); // A list to represent the board state
  String _currentPlayer = "X"; // Start with player X
  String _resultMessage = ''; // Message to show the result
  int points = 10;
  @override
  void initState() {
    super.initState();
    _resetGame(); // Reset the game at the start
  }

  void _handleTap(int index) {
    setState(() {
      if (_board[index] == '' && _resultMessage == '') {
        // Mark the board with the current player's symbol (X or O)
        _board[index] = _currentPlayer;

        // Check for winner or draw
        _checkWinner();
        // Switch player after each valid move
        if (_resultMessage == '') {
          _currentPlayer = _currentPlayer == "X" ? "O" : "X";
        }
      }
    });
  }

  void _checkWinner() {
    // Define all possible winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2], // Row 1
      [3, 4, 5], // Row 2
      [6, 7, 8], // Row 3
      [0, 3, 6], // Column 1
      [1, 4, 7], // Column 2
      [2, 5, 8], // Column 3
      [0, 4, 8], // Diagonal 1
      [2, 4, 6], // Diagonal 2
    ];

    // Check if any of the winning combinations is achieved
    for (var combo in winningCombinations) {
      if (_board[combo[0]] != '' &&
          _board[combo[0]] == _board[combo[1]] &&
          _board[combo[0]] == _board[combo[2]]) {
        _resultMessage = 'Player ${_board[combo[0]]} Wins!';
        if (_currentPlayer=="X"){
          points+=10;
        }
        return;
      }
    }

    // Check for a draw (i.e., no empty cells left)
    if (!_board.contains('')) {
      _resultMessage = 'It\'s a Draw!';
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, ''); // Clear the board
      _currentPlayer = "X"; // Reset to player X
      _resultMessage = ''; // Clear the result message
    });
  }
    final GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Adjust size if needed
        child: CustomAppBar(key: _appBarKey), // Assign GlobalKey to the AppBar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the 3x3 grid for the game
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 columns for Tic Tac Toe grid
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTap(index), // Handle tap on each cell
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        _board[index], // Display X or O based on the current state
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: _board[index] == 'X' ? Colors.blue : Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // Display result message
          Text(
            _resultMessage,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame, // Button to reset the game
            child: Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
