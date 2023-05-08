import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:openai_chatgpt_chatapp/models/conversation_model.dart';

import '../constants/constants.dart';
import '../database/database.dart';

class EditConversaion extends StatelessWidget {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  TextEditingController nameConvText = TextEditingController();
  Function hideEditConversation;
  ConversationModel conversation;
  Function loadData;
  EditConversaion(
      {super.key,
      required this.hideEditConversation,
      required this.conversation,
      required this.loadData});

  @override
  Widget build(BuildContext context) {
    nameConvText.text = conversation.name;

    return Material(
      color: cardColor,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Edit Conversation",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: nameConvText,
                        onSubmitted: (value) async {},
                        decoration: const InputDecoration.collapsed(
                            hintText: "Edit conversation",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Expanded(
                        child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green[700]),
                        onPressed: () async {
                          await saveUpdateConversation();
                          Navigator.of(context).pop();
                          loadData();
                        },
                        child: const Text(
                          "Save",
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
                            ElevatedButton.styleFrom(primary: Colors.pink[600]),
                        onPressed: () {
                          hideEditConversation();
                        },
                        child: const Text("Cancel",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    )),
                    const Padding(padding: EdgeInsets.only(right: 20)),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          )),
    );
  }

  Future<void> saveUpdateConversation() async {
    conversation.name = nameConvText.text;
    _databaseHelper.updateConv(conversation);
  }
}
