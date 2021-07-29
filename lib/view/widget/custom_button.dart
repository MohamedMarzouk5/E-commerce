import 'package:ecommerce/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButten extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomButten({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(18),
        onPressed: this.onPressed,
        child: CustomText(
          text: text,
          color: Colors.white,
          alignment: Alignment.center,
        ),
        color: Colors.green,
      ),
    );
  }
}
