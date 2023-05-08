import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:openai_chatgpt_chatapp/models/chat_model.dart';
import 'package:openai_chatgpt_chatapp/providers/chat_provider.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../database/database.dart';
import '../models/conversation_model.dart';
import '../providers/conversation_provider.dart';
import '../services/assets_manager.dart';
import '../services/services.dart';
import '../widgets/edit_conversation.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<ConversationModel> conversations = [];
  ConversationModel? edit_conversation;
  bool isShowEditConvModel = false;

  Future<void> loadData() async {
    var conversationList = await _databaseHelper.getAllConv();
    setState(() {
      conversations = conversationList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var conversationProvider = Provider.of<ConversationProvider>(context);
    var chatProvider = Provider.of<ChatProvider>(context);
    TextEditingController nameTextController = TextEditingController();

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    var prevPage = arguments?['prevPage'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color(0xFF151515),
          leading: GestureDetector(
            onTap: () {
              hideEditConversation();
              Navigator.pushNamed(context, prevPage);
            },
            child: const Icon(
              Icons.navigate_before,
              size: 44,
            ),
          ),
          title: Row(children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/openai_logo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("History Chat")
          ]),
        ),
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // color: conversations[index].id ==
                          //         conversationProvider.getConversation?.id
                          //     ? Color(0xFF3C3C3C)
                          //     : Color(0xFF191919),
                          color: edit_conversation?.id ==
                                  conversations[index].id
                              ? Color(0xFF293200)
                              : (conversations[index].id ==
                                      conversationProvider.getConversation?.id
                                  ? Color(0xFF3C3C3C)
                                  : Color(0xFF191919)),
                          child: ListTile(
                            onTap: () async {
                              // Handle onTap action here
                              conversationProvider.changeCurrentConversation(
                                  conversationModel: conversations[index]);
                              List<ChatModel> chats =
                                  await _databaseHelper.getChatByConversationId(
                                      conversations[index].id!);
                              chatProvider.changeChatList(chats: chats);
                              hideEditConversation();
                              Navigator.pushNamed(context, '/chat-screen');
                            },
                            leading: CircleAvatar(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              backgroundColor: edit_conversation?.id ==
                                      conversations[index].id
                                  ? Colors.yellow[900]
                                  : (conversations[index].id ==
                                          conversationProvider
                                              .getConversation?.id
                                      ? Colors.blue[700]
                                      : Colors.green[700]),
                            ),
                            title: Text(
                              conversations[index].name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            trailing: conversations[index].id ==
                                    conversationProvider.getConversation?.id
                                ? SizedBox.shrink()
                                : PopupMenuButton(
                                    color: Colors.white,
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        //open edit page
                                        setState(() {
                                          edit_conversation =
                                              conversations[index];
                                          isShowEditConvModel = true;
                                        });
                                      } else if (value == 'delete') {
                                        // delete and remove item
                                        hideEditConversation();
                                        Services.showEditConvModal(
                                            context: context,
                                            conversation: conversations[index],
                                            loadData: loadData as Function);
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text("Edit"),
                                          value: 'edit',
                                        ),
                                        PopupMenuItem(
                                          child: Text("Delete"),
                                          value: 'delete',
                                        )
                                      ];
                                    }),
                          ),
                        );
                      })),
              isShowEditConvModel
                  ? EditConversaion(
                      hideEditConversation: hideEditConversation,
                      conversation: edit_conversation as ConversationModel,
                      loadData: loadData as Function)
                  : SizedBox.shrink()
            ],
          ),
        )),
      ),
    );
  }

  void hideEditConversation() {
    setState(() {
      isShowEditConvModel = false;
      edit_conversation = null;
    });
  }
}
