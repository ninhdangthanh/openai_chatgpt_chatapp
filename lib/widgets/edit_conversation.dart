import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ChatGPT/models/conversation_model.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../database/database.dart';
import '../providers/colors_provider.dart';

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
    final myColorsProvider = Provider.of<MyColorsProvider>(context);
    nameConvText.text = conversation.name;

    return Material(
      color: myColorsProvider.cardColor,
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
                      color: myColorsProvider.textHeaderColor,
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
                            color: myColorsProvider.textHeaderColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: TextField(
                        style:
                            TextStyle(color: myColorsProvider.textHeaderColor),
                        controller: nameConvText,
                        onSubmitted: (value) async {},
                        decoration: InputDecoration.collapsed(
                            hintText: "Edit conversation",
                            hintStyle: TextStyle(
                                color: myColorsProvider.textInTextfield)),
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
                            primary: myColorsProvider.buttonGreenColor),
                        onPressed: () async {
                          await saveUpdateConversation();
                          await loadData();
                          await hideEditConversation();
                        },
                        child: Text(
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
                        style: ElevatedButton.styleFrom(
                            primary: myColorsProvider.buttonCancleColor),
                        onPressed: () {
                          hideEditConversation();
                        },
                        child: Text("Cancel",
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
    conversation.name = await nameConvText.text;
    await _databaseHelper.updateConv(conversation);
  }
}
