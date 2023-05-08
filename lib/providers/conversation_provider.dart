import 'package:flutter/cupertino.dart';
import 'package:openai_chatgpt_chatapp/database/database.dart';
import 'package:openai_chatgpt_chatapp/models/conversation_model.dart';

class ConversationProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  ConversationModel? conversation;

  ConversationModel? get getConversation {
    return conversation;
  }

  void changeCurrentConversation(
      {required ConversationModel conversationModel}) async {
    conversation = await conversationModel;
    notifyListeners();
  }
}
