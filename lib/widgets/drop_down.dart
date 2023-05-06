import 'package:flutter/material.dart';
import 'package:openai_chatgpt_chatapp/services/api_services.dart';
import 'package:openai_chatgpt_chatapp/widgets/text_widget.dart';

import '../constants/constants.dart';

class ModelsDrowDownWidget extends StatefulWidget {
  const ModelsDrowDownWidget({super.key});

  @override
  State<ModelsDrowDownWidget> createState() => _ModelsDrowDownWidgetState();
}

class _ModelsDrowDownWidgetState extends State<ModelsDrowDownWidget> {
  String currentModels = "gpt-3.5-turbo";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService.getModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: TextWidget(label: snapshot.error.toString()));
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                      dropdownColor: scaffoldBackgroundColor,
                      items: List<DropdownMenuItem<String>>.generate(
                          snapshot.data!.length,
                          (index) => DropdownMenuItem(
                              value: snapshot.data![index].id,
                              child: TextWidget(
                                label: snapshot.data![index].id,
                                fontSize: 15,
                              ))),
                      value: currentModels,
                      onChanged: (value) {
                        setState(() {
                          currentModels = value.toString();
                        });
                      }),
                );
        });
  }
}
