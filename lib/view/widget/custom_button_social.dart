import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtenSocial extends StatelessWidget {
  final String text;
  final String imageName;
  final Function onPressed;

  const CustomButtenSocial({this.text, this.imageName, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey.shade100),
      child: FlatButton(
        onPressed: this.onPressed,
        child: Row(
          children: [
            Image.asset(imageName),
            SizedBox(
              width: 90,
            ),
            CustomText(
              text: text,
            )
          ],
        ),
      ),
    );
  }
}
