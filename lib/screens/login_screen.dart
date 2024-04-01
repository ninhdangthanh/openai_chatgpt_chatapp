import 'package:ChatGPT/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/providers/conversation_provider.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';
import '../providers/colors_provider.dart';
import 'history_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
                  padding: const EdgeInsets.only(top: 40, bottom: 60),
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
                      const SizedBox(
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
              Padding(
                padding: EdgeInsets.only(right: 40, left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white)
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      width: screenWidth - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: myColorsProvider.buttonHistoryColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   '/history-screen',
                          //   arguments: {'prevPage': '/'},
                          // );
                        },
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: myColorsProvider.welcomButtomColor,
                                fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      child: const  Text("Create an account", style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
              const SizedBox(
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
