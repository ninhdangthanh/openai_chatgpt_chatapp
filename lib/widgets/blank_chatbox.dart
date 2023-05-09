import 'package:flutter/material.dart';

class BlankChatBox extends StatelessWidget {
  const BlankChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/blank_chat.png',
          width: 200,
          height: 200,
          color: Colors.green[900],
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Empty Chat History",
            style: TextStyle(
                color: Colors.white38,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
