import 'package:ChatGPT/constants/constants.dart';
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
          color: buttonGreenColor,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Empty Chat History",
            style: TextStyle(
                color: childHeaderColor,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
