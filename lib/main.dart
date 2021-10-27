import 'package:dialog_picker/dialog_picker.dart';
import 'package:dialog_picker/dialog_picker_style.dart';
import 'package:flutter/material.dart';

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
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(),
          contentTextStyle: TextStyle(),
          elevation: 8,
          shape: BeveledRectangleBorder(),
          backgroundColor: Colors.red
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
  final _data = ["Istanbul", "Ankara", "Bursa", "Izmir"];
  final _key = GlobalKey<DialogPickerState<String>>();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: const Text("Goster"),
            onPressed: () {
              showDialog<DialogPicker<String>>(
                barrierDismissible: false,
                context: context,
                builder: (context) => DialogPicker.custom<String>(
                  key: _key,
                  title: "Pick a City",
                  dataSource: _data,
                  selected: ["Istanbul"],
                  allowMultipleSelection: false,
                  style: DialogPickerStyle(
                    backgroundColor: Colors.red,
                    shape: BeveledRectangleBorder(),
                    elevation: 8,
                    contentTextStyle: TextStyle(),
                    titleTextStyle: TextStyle(),
                    searchTextStyle: TextStyle(),
                    brightness: Brightness.dark,
                    buttonTheme: TextStyle(),
                    headerColor: Colors.redAccent,
                    iconColor: Colors.blue,
                  ),
                  onCompletion: (List<String> selected) => Navigator.pop(context),
                  onCancel: () => Navigator.pop(context),
                ),
              );

              const sec = Duration(seconds: 1);
              Future.delayed(sec).then((value) => _key.currentState?.startLoading());

              const duration = Duration(seconds: 3);
              Future.delayed(duration).then((value) {
                final source = [
                  "Istanbul",
                  "Ankara",
                  "Bursa",
                  "Izmir",
                  "Edirne",
                ];
                _key.currentState?.update(source);
                _key.currentState?.stopLoading();
              });
            },
          ),
        ),
      ),
    );
  }
}
