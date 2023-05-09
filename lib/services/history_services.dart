import 'package:ChatGPT/models/chat_model.dart';
import 'package:ChatGPT/models/conversation_model.dart';

import '../database/database.dart';
import '../providers/conversation_provider.dart';

class HistoryService {
  static final DatabaseHelper _databaseHelper = DatabaseHelper();

  static void createNewChat(
      {required ConversationProvider conversationProvider}) async {
    ConversationModel? endConv = await _databaseHelper.getEndElemConversation();
    int newIdConv;
    if (endConv == null) {
      newIdConv = 1;
    } else {
      newIdConv = endConv.id! + 1;
    }
    ConversationModel newConversation = await _databaseHelper
        .addConv(ConversationModel(name: "New Chat ${newIdConv}"));
    endConv = await _databaseHelper.getEndElemConversation();
    conversationProvider.changeCurrentConversation(
        conversationModel: endConv as ConversationModel);
  }

  static void addChatToConversation(
      {required ChatModel chat,
      required ConversationModel conversation}) async {
    chat.conversationId = conversation.id;
    await _databaseHelper.addChat(chat);
  }
}
