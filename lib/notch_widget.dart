import 'package:flutter/material.dart';

class NotchWidget extends StatelessWidget {
  NotchWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 0),
      child: Container(
        width: 100,
        height: 4,
        decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(20))),
        alignment: Alignment.center,
      ),
    );
  }
}
