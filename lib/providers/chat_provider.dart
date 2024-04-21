import 'package:flutter/cupertino.dart';
import 'package:ChatGPT/models/conversation_model.dart';
import 'package:ChatGPT/providers/conversation_provider.dart';
import 'package:ChatGPT/services/history_services.dart';

import '../models/chat_model.dart';
import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  void changeChatList({required List<ChatModel> chats}) {
    chatList = chats;
    notifyListeners();
  }

  void generateNewChat(ConversationProvider conversationProvider) {
    chatList = [];
    HistoryService.createNewChat(conversationProvider: conversationProvider);
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg,
      required String chosenModelId,
      required ConversationModel conversationModel}) async {
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
      List<ChatModel> chats = await ApiService.sendMessageGPT(
        message: msg,
        modelId: chosenModelId,
      );
      chatList.addAll(chats);
      HistoryService.addChatToConversation(
          chat: chats[0], conversation: conversationModel);
      // for (var element in chats) {
      //   print("provider ${element.toString()}");
      //   print("provider ${chats.length}");
      // }
      // _databaseHelper
    } else {
      chatList.addAll(await ApiService.sendMessage(
        message: msg,
        modelId: chosenModelId,
      ));
    }
    notifyListeners();
  }
}
