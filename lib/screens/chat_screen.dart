import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/constants/constants.dart';
import 'package:openai_chatgpt_chatapp/services/api_services.dart';
import 'package:openai_chatgpt_chatapp/services/assets_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:openai_chatgpt_chatapp/widgets/text_widget.dart';

import '../services/services.dart';
import '../widgets/chat_widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
          title: Text("Chat GPT"),
          actions: [
            IconButton(
                onPressed: () async {
                  await Services.showModalSheet(context: context);
                },
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ))
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatMessages[index]["msg"].toString(),
                      chatIndex: chatMessages[index]["chatIndex"] as int,
                    );
                  }),
            ),
            if (_isTyping) ...[
              SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            Material(
              color: cardColor,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: textEditingController,
                      onSubmitted: (value) {
                        // TODO sent message
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: "How Can I Help You?",
                          hintStyle: TextStyle(color: Colors.grey)),
                    )),
                    IconButton(
                        onPressed: () async {
                          // try {
                          //   await ApiService.getModels();
                          // } catch (e) {
                          //   print(e);
                          // }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
