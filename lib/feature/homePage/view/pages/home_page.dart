import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tic_tac_toe/feature/homePage/view/widgets/player_container_widget.dart';
import 'package:tic_tac_toe/feature/homePage/view/widgets/winner_text_widget.dart';

class TicTacToe extends HookWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    final board = useState(List.filled(9, ""));
    final currentPlayer = useState("X");
    final winner = useState("");
    final isTie = useState(false);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).width;

    void checkForWinner() {
      ///possible winning lines
      List<List<int>> lines = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
      ];

      /// Check for winner
      for (var line in lines) {
        String p1 = board.value[line[0]];
        String p2 = board.value[line[1]];
        String p3 = board.value[line[2]];

        if (p1.isEmpty || p2.isEmpty || p3.isEmpty) continue;
        if (p1 == p2 && p2 == p3) {
          winner.value = p1;
          return;
        }
      }

      /// Check for Tie

      if (!board.value.contains("")) {
        isTie.value = true;
      }
    }

    /// currentPlayer Logic
    void player(int index) {
      if (winner.value != '' || board.value[index] != "") return;

      final newBoard = List<String>.from(board.value);
      newBoard[index] = currentPlayer.value;
      board.value = newBoard;
      currentPlayer.value = currentPlayer.value == "X" ? "O" : "X";
      checkForWinner();
    }

    /// Reset Game
    void resetGame() {
      board.value = List.filled(9, "");
      currentPlayer.value = "X";
      winner.value = "";
      isTie.value = false;
    }

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Player 1
              PlayerContainerWidget(
                isCurrentPlayer: currentPlayer.value == "X",
                playerName: "BOT 1",
                symbol: "X",
              ),

              /// Player 2
              SizedBox(width: width * 0.08),
              PlayerContainerWidget(
                isCurrentPlayer: currentPlayer.value == "O",
                playerName: "BOT 2",
                symbol: "O",
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
          if (winner.value.isNotEmpty) WinnerTextWidget(winner: winner.value),
          if (isTie.value)
            const Text(
              "It's a Tie!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

          /// Game Board
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 9,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => player(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      board.value[index],
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (winner.value.isNotEmpty || isTie.value)
            ElevatedButton(
              onPressed: resetGame,
              child: const Text("Play Again"),
            ),
        ],
      ),
    );
  }
}
