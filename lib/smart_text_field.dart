import 'package:flutter/material.dart';

enum SmartTextType { H1, T, QUOTE, BULLET }

const Map<String, SmartTextType> commandChar = {
  '# ': SmartTextType.H1,
  '. ': SmartTextType.T,
  '> ': SmartTextType.QUOTE,
  '- ': SmartTextType.BULLET,
};

extension SmartTextStyle on SmartTextType {
  TextStyle get textStyle {
    switch (this) {
      case SmartTextType.QUOTE:
        return TextStyle(fontSize: 16.0, color: Colors.white70);
      case SmartTextType.H1:
        return TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
      default:
        return TextStyle(fontSize: 16.0);
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case SmartTextType.H1:
        return EdgeInsets.fromLTRB(16, 24, 16, 8);
      case SmartTextType.BULLET:
        return EdgeInsets.fromLTRB(24, 8, 16, 8);
      default:
        return EdgeInsets.fromLTRB(16, 8, 16, 8);
    }
  }

  TextAlign get align {
    switch (this) {
      default:
        return TextAlign.start;
    }
  }

  String get prefix {
    switch (this) {
      case SmartTextType.BULLET:
        return '\u2022 ';
      case SmartTextType.QUOTE:
        return '|';
      default:
        return '';
    }
  }
}

class SmartTextField extends StatefulWidget {
  const SmartTextField({
    Key? key,
    required this.type,
    required this.controller,
    this.focusNode,
  }) : super(key: key);

  final SmartTextType type;
  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  _SmartTextFieldState createState() => _SmartTextFieldState();
}

class _SmartTextFieldState extends State<SmartTextField> {
  late SmartTextType type;

  @override
  void initState() {
    type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      toolbarOptions: ToolbarOptions(),
      controller: widget.controller,
      focusNode: widget.focusNode ?? FocusNode(),
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: Colors.teal,
      textAlign: type.align,
      onChanged: (String s) {
        commandChar.forEach((key, value) {
          if (s.startsWith(key)) {
            setState(() {
              type = value;
              widget.controller.clear();
            });
          }
        });
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixText: type.prefix,
        prefixStyle: type.textStyle,
        isDense: true,
        contentPadding: type.padding,
      ),
      style: type.textStyle,
    );
  }
}
