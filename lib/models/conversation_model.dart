class ConversationModel {
  int? id;
  String name;

  ConversationModel({required this.name, this.id});

  factory ConversationModel.fromJson(Map<dynamic, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return "ConversationModel --- id:$id --- name:$name";
  }
}
