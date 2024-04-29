import 'package:flutter/material.dart';
import 'package:ChatGPT/models/conversation_model.dart';
import 'package:ChatGPT/providers/conversation_provider.dart';

import '../providers/chat_provider.dart';
import '../providers/colors_provider.dart';

class Services {
  static Future<void> showModalSheet(
      {required BuildContext context,
      required ChatProvider chatProvider,
      required ConversationProvider conversationProvider,
      required MyColorsProvider myColorsProvider}) async {
    double screenWidth = MediaQuery.of(context).size.width;

    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: myColorsProvider.scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   width: screenWidth - 100,
                //   padding: EdgeInsets.only(bottom: 20),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Dark mode: ",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 28,
                //             color: myColorsProvider.textHeaderColor),
                //       ),
                //       Expanded(child: Container()),
                //       Switch(
                //         value: myColorsProvider.isDarkMode,
                //         onChanged: (value) => {myColorsProvider.changeMode()},
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  width: screenWidth - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: myColorsProvider.buttonGreenColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // chatProvider.generateNewChat(conversationProvider);
                      chatProvider.resetChatList();
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        "Reset Chat",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: screenWidth - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: myColorsProvider.buttonCancleColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // final route = MaterialPageRoute(
                      //     builder: (context) => HistoryScreen());
                      // Navigator.push(context, route);
                      // Navigator.pushNamed(context, '/history-screen');
                      // Navigator.pushNamed(
                      //   context,
                      //   '/history-screen',
                      //   arguments: {'prevPage': '/chat-screen'},
                      // );
                    },
                    child: const Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> showEditConvModal(
      {required BuildContext context,
      required ConversationModel conversation,
      required Function loadData}) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey[800],
        isScrollControlled: true,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Delete '${conversation.name}'",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Expanded(
                      child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 8, 24, 244)),
                      onPressed: () async {
                        // TODO delete conversation
                        // await _databaseHelper.deleteConv(conversation);
                        Navigator.of(context).pop();
                        await loadData();
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Expanded(
                      child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.pink[700]),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel",
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  )),
                  const Padding(padding: EdgeInsets.only(right: 20)),
                ],
              )
              //ok button
              ,
              const SizedBox(
                height: 100,
              )
            ],
          );
        });
  }
}
