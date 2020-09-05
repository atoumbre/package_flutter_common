import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

import 'DecoCard.dart';

class InputField extends StatefulWidget {
  final String text;
  final bool obscureText;
  final bool password;
  final bool email;
  final TextEditingController controller;

  InputField({this.obscureText = false, this.password = false, this.text, this.email = false, this.controller});

  @override
  _InputFieldState createState() =>
      _InputFieldState(text: text, obscureText: obscureText, password: password, email: email);
}

class _InputFieldState extends State<InputField> {
  String text;
  bool obscureText = false;
  bool password = false;
  bool email = false;

  _InputFieldState({this.obscureText, this.text, this.password, this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      child: DecoCard(
        padding: 0.0,
        child: Row(children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: email ? TextInputType.emailAddress : null,
              obscureText: obscureText ? true : false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 20.0),
                border: InputBorder.none,
                hintText: text,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 0.0),
            child: password
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    color: DecoColors.icon,
                    onPressed: _showHide,
                  )
                : null,
          ),
        ]),
      ),
    ));
  }

  _showHide() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
