import 'package:flutter/cupertino.dart';
import 'package:ChatGPT/database/database.dart';
import 'package:ChatGPT/models/conversation_model.dart';

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
