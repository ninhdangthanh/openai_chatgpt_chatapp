import 'package:ChatGPT/firebase_options.dart';
import 'package:ChatGPT/helper/helper_function.dart';
import 'package:ChatGPT/providers/colors_provider.dart';
import 'package:ChatGPT/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/providers/chat_provider.dart';
import 'package:ChatGPT/providers/conversation_provider.dart';
import 'package:ChatGPT/providers/models_provider.dart';
import 'package:ChatGPT/screens/chat_screen.dart';
import 'package:ChatGPT/screens/history_screen.dart';
import 'package:ChatGPT/screens/welcome.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
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
    ], child: const MyAppMaterial());
  }
}

class MyAppMaterial extends StatefulWidget {
  const MyAppMaterial({super.key});

  @override
  State<MyAppMaterial> createState() => _MyAppMaterialState();
}

class _MyAppMaterialState extends State<MyAppMaterial> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final myColorsProvider = Provider.of<MyColorsProvider>(context);

    return MaterialApp(
      title: 'Flutter ChatBOT',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/history-screen': (context) => const HistoryScreen(),
        '/chat-screen': (context) => const ChatScreen(),
      },
      theme: ThemeData(
          scaffoldBackgroundColor: myColorsProvider.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: myColorsProvider.cardColor,
          )),
      home: _isSignedIn ? const WelcomeScreen() : const LoginScreen(),
    );
  }
}
