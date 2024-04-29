import 'package:ChatGPT/helper/helper_function.dart';
import 'package:ChatGPT/screens/signup_screen.dart';
import 'package:ChatGPT/screens/welcome.dart';
import 'package:ChatGPT/service/auth_service.dart';
import 'package:ChatGPT/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/colors_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  void initState() {
    // _emailController.dispose();
    // _passwordController.dispose();
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

  void _handleSignIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    print("Email: $email");
    print("Password: $password");


    await authService
        .loginWithUserNameandPassword(email, password)
        .then((value) async {

      print("login $value");
      if (value == true) {
        print("login success");
        await HelperFunctions.saveUserLoggedInStatus(true);
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      } else {
        print("login failed");
        showSnackbar(context, Colors.red, value);
      }
    });

    print("login done");
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // final chatProvider = Provider.of<ChatProvider>(context);
    final myColorsProvider = Provider.of<MyColorsProvider>(context);
    // var conversationProvider = Provider.of<ConversationProvider>(context);

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
                      Row(
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
                                      color: myColorsProvider.buttonGreenColor,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
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
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white)
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white)
                      ),
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      // padding: const EdgeInsets.only(top: 6, bottom: 6),
                      width: screenWidth - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: myColorsProvider.buttonHistoryColor,
                      ),
                      child: TextButton(
                        onPressed: _handleSignIn,
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
                    GestureDetector (onTap: () {
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                      child: const Text("Create an account", style: TextStyle(color: Colors.white),)
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
