library dialog_picker;

import 'package:flutter/material.dart';

import 'dailog_picker_widget.dart';
import 'model/dialog_picker_item.dart';

class DialogPicker {
  static List<String> dataSource;
  static String title;
  static DialogPickerWidget widget;

  static void init({@required List<String> dataSource_, @required String title_}) {
    dataSource = dataSource_;
    title = title_;
  }

  static void show({@required BuildContext context, Function(int, String) selected}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.black,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              widget = dialogPickerWidget(selected);
              return widget;
            },
          );
        });
  }

  static Widget dialogPickerWidget(Function(int, String) selected) {
    return DialogPickerWidget(
      title: title,
      dataSource: dataSource,
      selected: selected,
    );
  }
}
