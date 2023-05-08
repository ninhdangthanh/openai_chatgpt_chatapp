import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/providers/conversation_provider.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
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
    var conversationProvider = Provider.of<ConversationProvider>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 80, bottom: 60),
                    child: Column(
                      children: [
                        Text(
                          "ChatGPT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "belongs to OpenAI",
                          style: TextStyle(
                            color: Color(0xFF8A8A8A),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: Image.asset(
                    'assets/images/openai_logo_purple.png',
                    width: 200,
                    height: 200,
                    color: Colors.green[900],
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  width: screenWidth - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.green[900],
                  ),
                  child: TextButton(
                    onPressed: () {
                      chatProvider.generateNewChat(conversationProvider);
                      Navigator.pushNamed(
                        context,
                        '/chat-screen',
                      );
                    },
                    child: const Center(
                      child: Text(
                        "New Chat",
                        style: TextStyle(color: Colors.white, fontSize: 24),
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
                    color: Colors.blue[800],
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
                        style: TextStyle(color: Colors.white, fontSize: 24),
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
        ));
  }
}
