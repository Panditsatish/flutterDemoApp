import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class LoginTextField extends StatelessWidget {
  Widget widget;
  Widget labelWidget;
   String labelText;
  final String hintText;
  TextInputType textInputType;
  bool obscureText;
  void Function(String) onChange;
  void Function()? onTap;

  LoginTextField(
      {Key? key,
       required this.labelText,
        this.textInputType = TextInputType.text,
        this.obscureText = false,
        required this.labelWidget,
        required this.widget,
        required this.onChange,
        required this.hintText,
        this.onTap
      })
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
          left: 35, right: 35, top: 35, bottom: 10),
      child: TextFormField(
        onChanged: onChange,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0, vertical: 5.0),
          suffixIcon: widget,
          hoverColor: Colors.deepPurpleAccent,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          label: labelWidget,
          hintText: hintText,
         ),
      ),
    );
  }
}
