import 'package:flutter/cupertino.dart';
import 'package:ChatGPT/models/conversation_model.dart';

class ConversationProvider with ChangeNotifier {
  ConversationModel? conversation;

  ConversationModel? get getConversation {
    return conversation;
  }

  void changeCurrentConversation(
      {required ConversationModel conversationModel}) async {
    conversation = conversationModel;
    notifyListeners();
  }
}
