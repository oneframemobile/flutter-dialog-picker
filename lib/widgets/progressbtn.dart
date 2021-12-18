import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  final VoidCallback onClick;
  final String text;
  final double btnWidth;
  final double btnHeight;
  final Color btnBackgroundColor;
  TextStyle? textStyle;

  ProgressButton({Key? key,
    required this.text,
    required this.onClick,
    required this.btnWidth,
    required this.btnHeight,
    required this.btnBackgroundColor,
    this.textStyle}) : super(key: key);

  @override
  ProgressButtonState createState() => ProgressButtonState();
}

class ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  int _state = 0;
  Animation? _animation;
  AnimationController? _controller;
  final GlobalKey _globalKey = GlobalKey();
  double? _width;
  double? _height;
  Color? _btnBackgroundColor;
  TextStyle? _textStyle;

  @override
  void initState() {
    _width = widget.btnWidth;
    _height = widget.btnHeight;
    _btnBackgroundColor = widget.btnBackgroundColor;
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _textStyle = widget.textStyle != null ? _textStyle = widget.textStyle : const TextStyle(color: Colors.white, fontSize: 16);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            key: _globalKey,
            height: _height,
            width: _width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.btnHeight / 2), // <-- Radius
                    ),
                    primary: _btnBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              child: setUpButtonChild(),
              onPressed: () {
                setState(() {
                  if (_state == 0) {
                    startLoading();
                    widget.onClick();
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  setUpButtonChild() {
    if (_state == 0) {
      return Text(
        widget.text,
        style: _textStyle,
      );
    } else if (_state == 1) {
      return const SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        widget.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    }
  }

  void startLoading() {
    animationPlay(0, 1.0, 1);
  }

  void stopLoading() {
    animationPlay(1.0, 0, 0);
  }

  animationPlay(begin, end, state) {
    double initialWidth = widget.btnWidth;
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: begin, end: end).animate(_controller!)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation!.value);
          _state = state;
        });
      });
    _controller!.forward();
  }
}