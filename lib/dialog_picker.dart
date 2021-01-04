library dialog_picker;
import 'package:flutter/material.dart';

import 'star_force_dailog_picker.dart';

class DialogPicker{
  static void show({
    @required String title,
    @required BuildContext context,
    @required List<String> dataSource,
    Function(int, String) selected

}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (BuildContext context) =>
          StarForceDialogPicker(
            title: title,
            dataSource: dataSource,
            selected: selected,
          ),
    );
  }
}
