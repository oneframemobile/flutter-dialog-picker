import 'dart:ui';

import 'package:flutter/material.dart';

class AppearanceModel {
  AppearanceModel(
      {this.dialogBackgroundColor = Colors.white,
      this.itemTextColor = Colors.black,
      this.selectedIconColor = Colors.black,
      this.dividerColor = Colors.grey,
      this.titleColor = Colors.black,
      this.searchBarColor = Colors.green,
      this.doneButtonColor = Colors.black,
      this.closeButtonColor = Colors.black,
      this.searchBarTextColor = Colors.black});

  Color dialogBackgroundColor;
  Color itemTextColor;
  Color selectedIconColor;
  Color dividerColor;
  Color titleColor;
  Color searchBarColor;
  Color searchBarTextColor;
  Color doneButtonColor;
  Color closeButtonColor;

  AppearanceModel setDarkTheme() {
    AppearanceModel _appearanceModel = new AppearanceModel();

    _appearanceModel.dialogBackgroundColor = Colors.black;
    _appearanceModel.itemTextColor = Colors.white;
    _appearanceModel.selectedIconColor = Colors.white;
    _appearanceModel.dividerColor = Colors.grey;
    _appearanceModel.titleColor = Colors.white;
    _appearanceModel.searchBarColor = Colors.green;
    _appearanceModel.doneButtonColor = Colors.white;
    _appearanceModel.closeButtonColor = Colors.white;
    _appearanceModel.searchBarTextColor = Colors.white;

    return _appearanceModel;
  }
}
