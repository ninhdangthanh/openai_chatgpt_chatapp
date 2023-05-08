import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/models/models_model.dart';
import 'package:openai_chatgpt_chatapp/services/api_services.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> models_list = [];

  List<ModelsModel> get getModelsList {
    return models_list;
  }

  Future<List<ModelsModel>> getAllModels() async {
    models_list = await ApiService.getModels();
    return models_list;
  }
}
