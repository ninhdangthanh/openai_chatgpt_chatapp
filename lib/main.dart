import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/providers/chat_provider.dart';
import 'package:openai_chatgpt_chatapp/providers/conversation_provider.dart';
import 'package:openai_chatgpt_chatapp/providers/models_provider.dart';
import 'package:openai_chatgpt_chatapp/screens/chat_screen.dart';
import 'package:openai_chatgpt_chatapp/screens/history_screen.dart';
import 'package:openai_chatgpt_chatapp/screens/test_screen.dart';
import 'package:openai_chatgpt_chatapp/screens/welcome.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConversationProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter ChatBOT',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/history-screen': (context) => HistoryScreen(),
          '/chat-screen': (context) => ChatScreen(),
        },
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(
              color: cardColor,
            )),
        home: WelcomeScreen(),
      ),
    );
  }
}
