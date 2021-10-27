import 'package:flutter/material.dart';

class DialogPickerStyle {
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final TextStyle? searchTextStyle;
  final TextStyle? buttonTheme;
  final Color? headerColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Brightness? brightness;

  DialogPickerStyle({
    this.titleTextStyle,
    this.contentTextStyle,
    this.searchTextStyle,
    this.buttonTheme,
    this.headerColor,
    this.backgroundColor,
    this.iconColor,
    this.elevation,
    this.shape,
    this.brightness,
  });

  static DialogPickerStyle light(BuildContext context) {
    final base = ThemeData.light();

    return DialogPickerStyle(
      titleTextStyle: base.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
      contentTextStyle: base.textTheme.bodyText1,
      searchTextStyle: base.textTheme.bodyText1,
      buttonTheme: base.textTheme.button,
      backgroundColor: base.cardColor,
      headerColor: Theme.of(context).colorScheme.primary,
      iconColor: base.iconTheme.color,
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      brightness: Brightness.light,
    );
  }

  static DialogPickerStyle dark(BuildContext context) {
    final base = ThemeData.dark();

    return DialogPickerStyle(
      titleTextStyle: base.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
      contentTextStyle: base.textTheme.bodyText1,
      searchTextStyle: base.textTheme.bodyText1,
      buttonTheme: base.textTheme.button,
      backgroundColor: const Color(0xFF212121),
      headerColor: const Color(0xFF212121),
      iconColor: base.iconTheme.color,
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      brightness: Brightness.dark,
    );
  }
}
