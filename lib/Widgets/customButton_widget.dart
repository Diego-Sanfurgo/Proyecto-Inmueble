import 'package:flutter/material.dart';
import 'package:formulario_4/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final String labelText;

  final void Function() onPress;

  CustomButton({this.onPress, this.color, this.iconData, this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) {
            return getColor(states, color);
          }),
        ),
        icon: Icon(iconData),
        label: Text(labelText, style: TextStyle(color: Colors.white)),
        onPressed: onPress,
      ),
    );
  }
}
