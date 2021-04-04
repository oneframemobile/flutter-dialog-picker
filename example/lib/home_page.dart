import 'package:dialog_picker/appearance_model.dart';
import 'package:dialog_picker/dialog_picker.dart';
import 'package:dialog_picker/enum/picker_theme.dart';
import 'package:dialog_picker/helper/get_list_helper.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String clickedValue = "";
  List<String> list;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Dialog Picker'),
        ),
        body: Center(
            child: InkWell(
          onTap: () async {
            DialogPicker.instance.init(
              dataSource: list,
              title: "Dialog Picker Template",
              selectedIndex: selectedIndex,
              theme: PickerTheme.DARK
            );

            DialogPicker.instance.show(
                context: context,
                selected: (index, item) {
                  setState(() {
                    clickedValue = item;
                    selectedIndex = index;
                  });
                });
          },
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Open Picker",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  )),
              SizedBox(
                height: 100,
              ),
              Text(clickedValue ?? "")
            ],
          ),
        )));
  }

  setData() async {
    list = await ListHelper.getStringList();

    Future.delayed(Duration(seconds: 10), () async {
      setState(() {
        list.add("Emre");
        DialogPicker.instance.updateData(list);
      });
    });
  }
}
