import 'package:flutter/material.dart';

class MyColorsProvider with ChangeNotifier {
  // dark mode
  bool isDarkMode = true;
  Color scaffoldBackgroundColor = const Color(0xFF141414);
  Color cardColor = const Color(0xFF1D1E22);
  Color cardColorHistory = const Color(0xFF191919);
  Color backgroundColor = const Color(0xFF000000);
  Color textHeaderColor = const Color(0xFFFFFFFF);
  Color childHeaderColor = const Color(0xFF8A8A8A);
  Color editHistoryColor = const Color(0xFF3E4327);
  Color selectHistoryColor = const Color(0xFF323741);
  Color normalHistoryColor = const Color(0xFF141414);
  Color textInTextfield = Colors.grey;
  Color welcomButtomColor = Colors.white;
  Color buttonGreenColor = Colors.green.shade900;
  Color buttonHistoryColor = Colors.blue.shade800;
  Color buttonCancleColor = Colors.pink.shade600;

  void changeMode() {
    if (isDarkMode) {
      //light mode
      isDarkMode = false;
      scaffoldBackgroundColor = const Color(0xFFFBFBFB);
      cardColor = const Color(0xFFA2A2A2);
      cardColorHistory = const Color(0xFFFCFCFC);
      backgroundColor = const Color(0xFFFFFFFF);
      textHeaderColor = const Color(0xFF000000);
      childHeaderColor = const Color(0xFF464646);
      editHistoryColor = const Color(0xFFEDFF9B);
      selectHistoryColor = const Color(0xFFA2B6DD);
      normalHistoryColor = const Color(0xFFC8C8C8);
      textInTextfield = const Color(0xFF3C3C3C);
      welcomButtomColor = Colors.black;
      buttonGreenColor = Colors.green.shade700;
      buttonHistoryColor = Colors.blue.shade600;
      buttonCancleColor = Colors.pink;
    } else {
      isDarkMode = true;
      scaffoldBackgroundColor = const Color(0xFF141414);
      cardColor = const Color(0xFF1D1E22);
      cardColorHistory = const Color(0xFF191919);
      backgroundColor = const Color(0xFF000000);
      textHeaderColor = const Color(0xFFFFFFFF);
      childHeaderColor = const Color(0xFF8A8A8A);
      editHistoryColor = const Color(0xFF3E4327);
      selectHistoryColor = const Color(0xFF323741);
      normalHistoryColor = const Color(0xFF141414);
      textInTextfield = Colors.grey;
      welcomButtomColor = Colors.white;
      buttonGreenColor = Colors.green.shade900;
      buttonHistoryColor = Colors.blue.shade800;
      buttonCancleColor = Colors.pink.shade600;
    }
    notifyListeners();
  }
}
