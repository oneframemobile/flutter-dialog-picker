import 'package:dialog_picker/dialog_picker.dart';
import 'package:dialog_picker/helper/get_list_helper.dart';
import 'package:flutter/material.dart';
import 'package:location_manager_example/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, navigatorKey: navigatorKey, title: 'Dialog Picker', home: new HomePageView());
  }
}
