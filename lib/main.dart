import 'package:ChatGPT/providers/colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/providers/chat_provider.dart';
import 'package:ChatGPT/providers/conversation_provider.dart';
import 'package:ChatGPT/providers/models_provider.dart';
import 'package:ChatGPT/screens/chat_screen.dart';
import 'package:ChatGPT/screens/history_screen.dart';
import 'package:ChatGPT/screens/test_screen.dart';
import 'package:ChatGPT/screens/welcome.dart';
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
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ModelsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ConversationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MyColorsProvider(),
      ),
    ], child: MyAppMaterial());
  }
}

class MyAppMaterial extends StatefulWidget {
  const MyAppMaterial({super.key});

  @override
  State<MyAppMaterial> createState() => _MyAppMaterialState();
}

class _MyAppMaterialState extends State<MyAppMaterial> {
  @override
  Widget build(BuildContext context) {
    final myColorsProvider = Provider.of<MyColorsProvider>(context);

    return MaterialApp(
      title: 'Flutter ChatBOT',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/history-screen': (context) => HistoryScreen(),
        '/chat-screen': (context) => ChatScreen(),
      },
      theme: ThemeData(
          scaffoldBackgroundColor: myColorsProvider.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: myColorsProvider.cardColor,
          )),
      home: WelcomeScreen(),
    );
  }
}
