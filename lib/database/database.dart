import 'dart:io';

import 'package:ChatGPT/models/chat_model.dart';
import 'package:ChatGPT/models/conversation_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  //create a function to open

  Future openDB() async {
    _database ??= await openDatabase(join(await getDatabasesPath(), "mydb.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE conversations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
      await db.execute('''
        CREATE TABLE chats(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          msg TEXT,
          chatIndex INTEGER,
          conversationId INTEGER,
          FOREIGN KEY (conversationId) REFERENCES conversations (id) ON DELETE CASCADE
        )
      ''');
    });
  }

  Future<void> clearDataInDb() async {
    await openDB();
    await _database!.delete('chats');
    await _database!.delete('conversations');
  }

  Future<void> initDatabase() async {
    await openDB();

    // First, insert some conversations
    await _database!.insert('conversations', {'name': 'Conversation 1'});
    await _database!.insert('conversations', {'name': 'Conversation 2'});
    await _database!.insert('conversations', {'name': 'Conversation 3'});
    await _database!.insert('conversations', {'name': 'Conversation 4'});

// Then, insert some chats for each conversation
    int conversationId = 1; // Conversation 1
    await _database!.insert('chats',
        {'msg': 'Hello', 'chatIndex': 0, 'conversationId': conversationId});
    await _database!.insert('chats', {
      'msg': 'How are you?',
      'chatIndex': 1,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'I\'m good, thanks!',
      'chatIndex': 0,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'What about you?',
      'chatIndex': 1,
      'conversationId': conversationId
    });

    conversationId = 2; // Conversation 2
    await _database!.insert('chats', {
      'msg': 'Hey there!',
      'chatIndex': 0,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'I\'m fine, thanks!',
      'chatIndex': 1,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'What are you up to?',
      'chatIndex': 0,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'Not much, just hanging out.',
      'chatIndex': 1,
      'conversationId': conversationId
    });

// Add more chats for conversations 3 and 4 as needed
// Add chats for conversation 3
    conversationId = 3;
    await _database!.insert('chats',
        {'msg': 'Hi!', 'chatIndex': 0, 'conversationId': conversationId});
    await _database!.insert('chats', {
      'msg': 'How\'s your day going?',
      'chatIndex': 1,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'It\'s going well, thanks for asking!',
      'chatIndex': 0,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'What about you?',
      'chatIndex': 1,
      'conversationId': conversationId
    });

// Add chats for conversation 4
    conversationId = 4;
    await _database!.insert('chats',
        {'msg': 'Hey!', 'chatIndex': 0, 'conversationId': conversationId});
    await _database!.insert('chats', {
      'msg': 'How was your weekend?',
      'chatIndex': 1,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'It was great, thanks!',
      'chatIndex': 0,
      'conversationId': conversationId
    });
    await _database!.insert('chats', {
      'msg': 'What did you do?',
      'chatIndex': 1,
      'conversationId': conversationId
    });
  }

// CONVERSATION SERVICE
  Future<ConversationModel> addConv(ConversationModel conv) async {
    await openDB();
    await _database!.insert('conversations', conv.toJson());
    return conv;
  }

  Future<List<ConversationModel>> getAllConv() async {
    await openDB();
    final List<Map<String, dynamic>> convs =
        await _database!.query('conversations');

    return convs.map((todo) => ConversationModel.fromJson(todo)).toList();
  }

  Future<ConversationModel?> getConvById(int id) async {
    await openDB();
    final List<Map> convs = await _database!
        .query('conversations', where: "id = ?", whereArgs: [id]);

    if (convs.length > 0) {
      return ConversationModel.fromJson(convs.first);
    }
    return null;
  }

  Future<ConversationModel?> getEndElemConversation() async {
    await openDB();
    final List<Map<String, dynamic>> convs =
        await _database!.query('conversations');

    if (convs.length > 0) {
      return ConversationModel.fromJson(convs.last);
    }
    return null;
  }

  Future<int> updateConv(ConversationModel conv) async {
    await openDB();
    var updateConv = await _database!.update('conversations', conv.toJson(),
        where: "id = ?", whereArgs: [conv.id]);
    return updateConv;
  }

  Future<void> deleteConv(ConversationModel conv) async {
    await openDB();
    await _database!
        .delete('conversations', where: "id = ?", whereArgs: [conv.id]);
  }

// CHAT SERVICE
  Future<List<ChatModel>> getAllChat() async {
    await openDB();
    final List<Map<String, dynamic>> chats = await _database!.query('chats');

    return chats.map((chat) => ChatModel.fromJsonFromSqlite(chat)).toList();
  }

  Future<ChatModel> addChat(ChatModel chat) async {
    await openDB();
    await _database!.insert('chats', chat.toJson());
    return chat;
  }

  Future<List<ChatModel>> getChatByConversationId(int id) async {
    await openDB();
    final List<Map<String, dynamic>> chats = await _database!
        .query('chats', where: "conversationId = ?", whereArgs: [id]);

    return chats.map((chats) => ChatModel.fromJsonFromSqlite(chats)).toList();
  }

  Future<void> deleteChatByConversationId(int id) async {
    await openDB();
    await _database!
        .delete('chats', where: "conversationId = ?", whereArgs: [id]);
  }
}
