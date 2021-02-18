import 'package:dialog_picker/dialog_picker.dart';
import 'package:dialog_picker/helper/get_list_helper.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String clickedValue = "";
  List<String> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dialog Picker'),
        ),
        body: Center(
            child: InkWell(
          onTap: () async {
            DialogPicker.init(
              dataSource_: list,
              title_: "Dialog Picker Template",
            );
            DialogPicker.show(
                context: context,
                selected: (index, item) {
                  setState(() {
                    clickedValue = item;
                  });
                });
          },
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                  color: Colors.deepOrange,
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

    /*Future.delayed(Duration(seconds: 10), () async {
      setState(() {
        list.add("Emre");
        DialogPicker.reload(list);
      });
    });*/
  }
}
