// dark mode

// Color scaffoldBackgroundColor = const Color(0xFF141414);
// Color cardColor = const Color(0xFF1D1E22);
// Color cardColorHistory = const Color(0xFF191919);
// Color backgroundColor = const Color(0xFF000000);
// Color textHeaderColor = const Color(0xFFFFFFFF);
// Color childHeaderColor = const Color(0xFF8A8A8A);
// Color editHistoryColor = const Color(0xFF3E4327);
// Color selectHistoryColor = const Color(0xFF323741);
// Color normalHistoryColor = const Color(0xFF141414);
// Color textInTextfield = Colors.grey;
// Color welcomButtomColor = Colors.white;
// Color buttonGreenColor = Colors.green.shade900;
// Color buttonHistoryColor = Colors.blue.shade800;
// Color buttonCancleColor = Colors.pink.shade600;

//light mode

// Color scaffoldBackgroundColor = const Color(0xFFFBFBFB);
// Color cardColor = const Color(0xFFA2A2A2);
// Color cardColorHistory = const Color(0xFFFCFCFC);
// Color backgroundColor = const Color(0xFFFFFFFF);
// Color textHeaderColor = const Color(0xFF000000);
// Color childHeaderColor = const Color(0xFF464646);
// Color editHistoryColor = const Color(0xFFEDFF9B);
// Color selectHistoryColor = const Color(0xFFA2B6DD);
// Color normalHistoryColor = const Color(0xFFC8C8C8);
// Color textInTextfield = const Color(0xFF3C3C3C);
// Color welcomButtomColor = Colors.black;
// Color buttonGreenColor = Colors.green.shade700;
// Color buttonHistoryColor = Colors.blue.shade600;
// Color buttonCancleColor = Colors.pink;

// List<String> models = [
//   'Model1',
//   'Model2',
//   'Model3',
//   'Model4',
//   'Model5',
//   'Model6',
// ];

// List<DropdownMenuItem<String>>? get getModelsItem {
//   List<DropdownMenuItem<String>>? modelsItems =
//       List<DropdownMenuItem<String>>.generate(
//           models.length,
//           (index) => DropdownMenuItem(
//               value: models[index],
//               child: TextWidget(
//                 label: models[index],
//                 fontSize: 15,
//               )));
//   return modelsItems;
// }

final chatMessages = [
  // 0 is user sent message
  // 1 is response from chat gpt
  {
    "msg": "Hello who are you?",
    "chatIndex": 0,
  },
  {
    "msg":
        "Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you with any information or questions you may have. How can I help you today?",
    "chatIndex": 1,
  },
  {
    "msg": "What is flutter?",
    "chatIndex": 0,
  },
  {
    "msg":
        "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web. Flutter uses the Dart programming language and allows for the creation of high-performance, visually attractive, and responsive apps. It also has a growing and supportive community, and offers many customizable widgets for building beautiful and responsive user interfaces.",
    "chatIndex": 1,
  },
  {
    "msg": "Okay thanks",
    "chatIndex": 0,
  },
  {
    "msg":
        "You're welcome! Let me know if you have any other questions or if there's anything else I can help you with.",
    "chatIndex": 1,
  },
];
