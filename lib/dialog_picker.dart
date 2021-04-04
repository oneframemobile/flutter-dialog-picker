library dialog_picker;

import 'package:dialog_picker/appearance_model.dart';
import 'package:dialog_picker/enum/picker_theme.dart';
import 'package:flutter/material.dart';

import 'dailog_picker_widget.dart';


class DialogPicker {
  static DialogPicker _instance;
  List<String> dataSource_;
  String title_;
  int selectedIndex_;
  AppearanceModel appearanceModel_;
  PickerTheme theme_;
  static DialogPickerWidget widget;
  static PickerTheme pickerTheme;

  DialogPicker._privateConstructor();

  static DialogPicker get instance {
    if (_instance == null) {
      _instance = new DialogPicker._privateConstructor();
      widget = new DialogPickerWidget();
      pickerTheme = PickerTheme.DARK;
    }
    return _instance;
  }

  void setContext(){

  }



  void init({@required List<String> dataSource, @required String title, int selectedIndex, AppearanceModel appearanceModel, PickerTheme theme}) {
    dataSource_ = dataSource;
    title_ = title;
    selectedIndex_= selectedIndex;
    appearanceModel_ = appearanceModel;
    theme_ = theme;
  }

  show({@required BuildContext context, Function(int, String) selected}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          widget = DialogPickerWidget(
            title: title_,
            dataSource: dataSource_,
            selected: selected,
            selectedIndex: selectedIndex_,
            appearanceModel: appearanceModel_,
            theme: theme_,
          );
          return widget;
        });
  }

/*  Widget dialogPickerWidget(Function(int, String) selected) {
    return DialogPickerWidget(
      title: title,
      dataSource: dataSource,
      selected: selected,
    );
  }*/

  void updateData(List<String> list) {
    widget.dataSource = list;
  }
}
