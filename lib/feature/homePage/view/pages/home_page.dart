import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TicTacToe extends HookWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    final board = useState(List.filled(9, ""));
    final currentPlayer = useState("X");
    final winner = useState("");
    final isTie = useState(false);
    final size = MediaQuery.of(context).size;

    void checkForWinner() {
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

      if (!board.value.contains("")) {
        isTie.value = true;
      }
    }

    void player(int index) {
      if (winner.value != '' || board.value[index] != "") return;

      final newBoard = List<String>.from(board.value);
      newBoard[index] = currentPlayer.value;
      board.value = newBoard;
      currentPlayer.value = currentPlayer.value == "X" ? "O" : "X";
      checkForWinner();
    }

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
              _PlayerContainer(
                isCurrentPlayer: currentPlayer.value == "X",
                playerName: "BOT 1",
                symbol: "X",
              ),
              SizedBox(width: size.width * 0.08),
              _PlayerContainer(
                isCurrentPlayer: currentPlayer.value == "O",
                playerName: "BOT 2",
                symbol: "O",
              ),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          if (winner.value.isNotEmpty) _WinnerText(winner: winner.value),
          if (isTie.value)
            const Text(
              "It's a Tie!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
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

class _PlayerContainer extends StatelessWidget {
  final bool isCurrentPlayer;
  final String playerName;
  final String symbol;

  const _PlayerContainer({
    required this.isCurrentPlayer,
    required this.playerName,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCurrentPlayer ? Colors.amber : Colors.transparent,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
              size: 55,
            ),
            const SizedBox(height: 10),
            Text(
              playerName,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              symbol,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WinnerText extends StatelessWidget {
  final String winner;

  const _WinnerText({required this.winner});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          winner,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          " WON!",
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
