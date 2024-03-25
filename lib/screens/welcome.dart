import 'package:ChatGPT/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/providers/conversation_provider.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
import '../providers/colors_provider.dart';
import 'history_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController to control the rotation animation.
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final chatProvider = Provider.of<ChatProvider>(context);
    final myColorsProvider = Provider.of<MyColorsProvider>(context);
    var conversationProvider = Provider.of<ConversationProvider>(context);

    return Scaffold(
      backgroundColor: myColorsProvider.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 80, bottom: 60),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                                  Text(
                                    "MYA",
                                    style: TextStyle(
                                        color: myColorsProvider.buttonHistoryColor,
                                        fontSize: 55,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "bot",
                                    style: TextStyle(
                                        color: myColorsProvider.textHeaderColor,
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "AI",
                                    style: TextStyle(
                                        color: myColorsProvider.textHeaderColor,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ],
                        )
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  )),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Image.asset(
                  'assets/images/openai_logo_purple.png',
                  width: 200,
                  height: 200,
                  color: const Color.fromARGB(255, 8, 24, 244),
                ),
              ),
              Expanded(child: Container()),
              Container(
                width: screenWidth - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: myColorsProvider.buttonGreenColor,
                ),
                child: TextButton(
                  onPressed: () {
                    chatProvider.generateNewChat(conversationProvider);
                    Navigator.pushNamed(
                      context,
                      '/chat-screen',
                    );
                  },
                  child: Center(
                    child: Text(
                      "New Chat",
                      style: TextStyle(
                          color: myColorsProvider.welcomButtomColor,
                          fontSize: 24),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: screenWidth - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: myColorsProvider.buttonHistoryColor,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/history-screen',
                      arguments: {'prevPage': '/'},
                    );
                  },
                  child: Center(
                    child: Text(
                      "History",
                      style: TextStyle(
                          color: myColorsProvider.welcomButtomColor,
                          fontSize: 24),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     myColorsProvider.changeMode();
      //   },
      //   child: Icon(Icons.color_lens),
      // ),
    );
  }
}
