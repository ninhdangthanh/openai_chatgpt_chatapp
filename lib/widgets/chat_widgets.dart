import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/constants/constants.dart';
import 'package:openai_chatgpt_chatapp/services/assets_manager.dart';
import 'package:openai_chatgpt_chatapp/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  final String msg;
  final int chatIndex;

  ChatWidget({super.key, required this.msg, required this.chatIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: TextWidget(label: msg)),
                chatIndex == 0
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
