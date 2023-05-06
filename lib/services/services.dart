import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/widgets/drop_down.dart';

import '../constants/constants.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: TextWidget(
                  label: "Choose Model: ",
                  fontSize: 16,
                )),
                Flexible(flex: 3, child: ModelsDrowDownWidget())
              ],
            ),
          );
        });
  }
}
