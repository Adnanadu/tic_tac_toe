import 'package:flutter/material.dart';

class ResetButtonWidget extends StatelessWidget {
  const ResetButtonWidget({
    super.key,
    required this.resetGame,
  });
  final void Function() resetGame;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: IconButton(
                onPressed: resetGame,
                icon: Icon(
                  Icons.replay_circle_filled_rounded,
                ),
                iconSize: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
