import 'package:flutter/material.dart';
import 'package:ChatGPT/widgets/blank_chatbox.dart';
import 'package:provider/provider.dart';

import '../models/conversation_model.dart';
import '../providers/colors_provider.dart';
import '../providers/conversation_provider.dart';
import '../services/services.dart';
import '../widgets/edit_conversation.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ConversationModel> conversations = [];
  // ignore: non_constant_identifier_names
  ConversationModel? edit_conversation;
  bool isShowEditConvModel = false;
  bool isLoading = true;

  Future<void> loadData() async {
    // await _databaseHelper.initDatabase();
    // ignore: prefer_typing_uninitialized_variables
    var conversationList;
    setState(() {
      conversations = conversationList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var conversationProvider = Provider.of<ConversationProvider>(context);
    // var chatProvider = Provider.of<ChatProvider>(context);
    final myColorsProvider = Provider.of<MyColorsProvider>(context);
    // TextEditingController nameTextController = TextEditingController();

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    var prevPage = arguments?['prevPage'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: myColorsProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: myColorsProvider.cardColor,
          leading: GestureDetector(
            onTap: () {
              hideEditConversation();
              Navigator.pushNamed(context, prevPage);
            },
            child: const Icon(
              Icons.navigate_before,
              size: 44,
              color: Colors.white,
            ),
          ),
          title: Row(children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(
                'assets/images/openai_logo_purple.png',
                width: 40,
                height: 40,
                color: const Color.fromARGB(255, 8, 24, 244),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "History Chat",
              style: TextStyle(color: myColorsProvider.welcomButtomColor),
            )
          ]),
        ),
        body: SafeArea(
            child: Visibility(
          visible: isLoading,
          replacement: RefreshIndicator(
            onRefresh: loadData,
            child: Column(
              children: [
                Expanded(
                    child: conversations.isEmpty
                        ? const BlankChatBox()
                        : ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: conversations.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: edit_conversation?.id ==
                                        conversations[index].id
                                    ? myColorsProvider.editHistoryColor
                                    : (conversations[index].id ==
                                            conversationProvider
                                                .getConversation?.id
                                        ? myColorsProvider.selectHistoryColor
                                        : myColorsProvider
                                            .normalHistoryColor),
                                child: ListTile(
                                  onTap: () async {
                                    hideEditConversation();
                                    Navigator.pushNamed(
                                        context, '/chat-screen');
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: edit_conversation?.id ==
                                            conversations[index].id
                                        ? Colors.yellow[900]
                                        : (conversations[index].id ==
                                                conversationProvider
                                                    .getConversation?.id
                                            ? myColorsProvider
                                                .buttonGreenColor
                                            : myColorsProvider
                                                .buttonHistoryColor),
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: myColorsProvider
                                              .textHeaderColor),
                                    ),
                                  ),
                                  title: Text(
                                    conversations[index].name,
                                    style: TextStyle(
                                        color:
                                            myColorsProvider.textHeaderColor,
                                        fontSize: 20),
                                  ),
                                  trailing: conversations[index].id ==
                                          conversationProvider
                                              .getConversation?.id
                                      ? const SizedBox.shrink()
                                      : PopupMenuButton(
                                          color: myColorsProvider
                                              .textHeaderColor,
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
                                                  conversation:
                                                      conversations[index],
                                                  loadData:
                                                      loadData as Function);
                                            }
                                          },
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                value: 'edit',
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: myColorsProvider
                                                          .backgroundColor),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 'delete',
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: myColorsProvider
                                                          .backgroundColor),
                                                ),
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
                    : const SizedBox.shrink()
              ],
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
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
