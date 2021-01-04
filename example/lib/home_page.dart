import 'package:dialog_picker/dialog_picker.dart';
import 'package:dialog_picker/helper/get_list_helper.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String clickedValue = "";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Starforce Dialog Picker'),
        ),
        body: Center(
            child: InkWell(
              onTap: () async {
                DialogPicker.show(
                    title: "Title",
                    context: context,
                    dataSource: await ListHelper.getStringList(),
                    selected: (a, b) {
                      print("$a --- $b");
                     setState(() {
                       clickedValue = b;
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
}
