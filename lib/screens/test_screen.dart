import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/models/chat_model.dart';
import 'package:openai_chatgpt_chatapp/models/conversation_model.dart';
import 'package:openai_chatgpt_chatapp/providers/conversation_provider.dart';
import 'package:openai_chatgpt_chatapp/services/history_services.dart';
import 'package:provider/provider.dart';

import '../database/database.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<ConversationModel> conversations = [];
  List<ChatModel> chats = [];

  Future<void> _loadData() async {
    var conversation_list = await _databaseHelper.getAllConv();
    var chat_list = await _databaseHelper.getChatByConversationId(2);
    setState(() {
      conversations = conversation_list;
      chats = chat_list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ConversationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat GPT Test Screen"),
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          SizedBox(
            height: 180,
          ),
          Text(
            "Test",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TextButton(
              onPressed: () {
                submitData(chatProvider);
              },
              child: Text(
                "Data submit",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ))),
    );
  }

  Future<void> submitData(ConversationProvider conversationProvider) async {
    print("click submit");
    //have conversation
    await _databaseHelper.clearDataInDb();
  }
}
