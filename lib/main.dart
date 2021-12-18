import 'dart:convert';

import 'package:dialog_picker/widgets/dialog_picker.dart';
import 'package:dialog_picker/widgets/progressbtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/dialog_picker_data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
        ),
        dialogTheme: const DialogTheme(
          titleTextStyle: TextStyle(),
          contentTextStyle: TextStyle(),
          elevation: 8,
          shape: BeveledRectangleBorder(),
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurple,
        ),
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final _key = GlobalKey<DialogPickerState<DialogPickerDataModel>>();
  final _keyProgressBtn = GlobalKey<ProgressButtonState>();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ProgressButton(
            key: _keyProgressBtn,
            btnHeight: 48,
            btnWidth: MediaQuery.of(context).size.width,
            onClick: () => show(context),
            text: "Göster",
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            btnBackgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  show(BuildContext context) {
    _keyProgressBtn.currentState?.startLoading();
    const duration = Duration(seconds: 2);
    Future.delayed(duration).then((value) async {
      final String response = await rootBundle.loadString('assets/sample.json');
      _keyProgressBtn.currentState?.stopLoading();
      try {
        List<DialogPickerDataModel> list = parseJson(response);
        showDialog<DialogPicker<DialogPickerDataModel>>(
          barrierDismissible: false,
          context: context,
          builder: (context) => DialogPicker.custom<DialogPickerDataModel>(
              key: _key,
              title: "Pick a Company",
              dataSource: list,
              selected: [],
              allowMultipleSelection: true,
              onCompletion: (List<DialogPickerDataModel> selected) {
                Navigator.pop(context);
                if (selected.isNotEmpty) {
                  selected.forEach((element) {
                    print(element.title);
                  });
                }
              },
              onCancel: () {
                Navigator.pop(context);
              },
              errorDescription: "Liste boş!",
              errorIcon: Icons.error,
              cancelBtn: "İptal",
              okBtn: "Tamamdır"
          ),
        );
      } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: Text(e.toString())
            )
        );
      }
    });
  }

  List<DialogPickerDataModel> parseJson(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<DialogPickerDataModel>((json) => DialogPickerDataModel.fromJson(json)).toList();
  }

}
