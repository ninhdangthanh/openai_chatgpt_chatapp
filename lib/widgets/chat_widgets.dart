import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/constants/constants.dart';
import 'package:ChatGPT/services/assets_manager.dart';
import 'package:ChatGPT/widgets/text_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../providers/colors_provider.dart';

class ChatWidget extends StatefulWidget {
  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  bool isSpeaking;
  Function changeSpeaking;

  ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      required this.shouldAnimate,
      required this.isSpeaking,
      required this.changeSpeaking});

  @override
  State<ChatWidget> createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatWidget> {
  TextEditingController textEditingController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  ValueNotifier<bool> isSpeakingText = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    initTts();
  }

  void setFalse() {
    setState(() {
      isSpeakingText.value = false;
    });
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1);

    flutterTts.setCompletionHandler(() {
      if (widget.isSpeaking) {
        widget.changeSpeaking();
        setState(() {
          isSpeakingText.value = false;
        });

        print("end------- $isSpeakingText.value");
      }
    });
  }

  Future<void> speak() async {
    if (widget.isSpeaking == false) {
      await flutterTts.speak(widget.msg);
      widget.changeSpeaking();
      setState(() {
        isSpeakingText.value = true;
      });
    }
  }

  Future<void> stop() async {
    if (widget.isSpeaking) {
      await flutterTts.stop();
      widget.changeSpeaking();
      setState(() {
        isSpeakingText.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final myColorsProvider = Provider.of<MyColorsProvider>(context);

    return Column(
      children: [
        Material(
          color: widget.chatIndex == 0
              ? myColorsProvider.scaffoldBackgroundColor
              : myColorsProvider.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  height: 30,
                  width: 30,
                  color: widget.chatIndex != 0 ? myColorsProvider.buttonHistoryColor : null,
                ),
                // Container(
                //   height: 30,
                //   width: 30,
                //   child:  Image.asset(
                //       'assets/images/openai_logo_purple.png',
                //       width: 30,
                //       height: 30,
                //       color: const Color.fromARGB(255, 8, 24, 244),
                //     ),
                // ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: widget.chatIndex == 0
                      ? TextWidget(
                          label: widget.msg,
                        )
                      : widget.shouldAnimate
                          ? DefaultTextStyle(
                              style: TextStyle(
                                  color: myColorsProvider.textHeaderColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              child: Text(widget.msg.trim()),
                            )
                          : Text(
                              widget.msg.trim(),
                              style: TextStyle(
                                  color: myColorsProvider.textHeaderColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                ),
                widget.chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder(
                              valueListenable: isSpeakingText,
                              builder: (context, value, child) {
                                if (value && widget.isSpeaking) {
                                  return InkWell(
                                    onTap: () {
                                      stop();
                                    },
                                    child: Icon(
                                      Icons.stop_circle_outlined,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      speak();
                                    },
                                    child: Icon(
                                      Icons.volume_up,
                                      color:
                                          myColorsProvider.buttonHistoryColor,
                                      size: 30,
                                    ),
                                  );
                                }
                              })
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
    ;
  }
}
