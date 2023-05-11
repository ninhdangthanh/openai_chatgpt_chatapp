import 'package:ChatGPT/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/colors_provider.dart';

class BlankChatBox extends StatelessWidget {
  const BlankChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    final myColorsProvider = Provider.of<MyColorsProvider>(context);

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/blank_chat.png',
          width: 200,
          height: 200,
          color: myColorsProvider.buttonGreenColor,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Empty Chat History",
            style: TextStyle(
                color: myColorsProvider.childHeaderColor,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
