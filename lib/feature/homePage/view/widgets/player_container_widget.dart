import 'package:flutter/material.dart';

class PlayerContainerWidget extends StatelessWidget {
  final bool isCurrentPlayer;
  final String playerName;
  final String symbol;

  const PlayerContainerWidget({
    super.key,
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
