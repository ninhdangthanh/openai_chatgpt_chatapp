class ChatModel {
  int? id;
  final String msg;
  final int chatIndex;
  int? conversationId;

  ChatModel(
      {required this.msg,
      required this.chatIndex,
      this.id,
      this.conversationId});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json["msg"],
        chatIndex: json["chatIndex"],
      );

  factory ChatModel.fromJsonFromSqlite(Map<String, dynamic> json) => ChatModel(
      id: json["id"],
      msg: json["msg"],
      chatIndex: json["chatIndex"],
      conversationId: json["conversationId"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['msg'] = msg;
    data['chatIndex'] = chatIndex;
    data['conversationId'] = conversationId;
    return data;
  }

  @override
  String toString() {
    return "Chat --- id:$id --- msg:$msg --- chatIndex:$chatIndex ---- conversationId:$conversationId";
  }
}
