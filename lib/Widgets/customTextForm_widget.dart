import 'package:flutter/material.dart';
import 'package:formulario_4/utils/utils.dart';

class CustomTextForm extends StatelessWidget {
  int valorInmueble;
  String label;
  String hint;

  CustomTextForm(this.valorInmueble, {this.label, this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: valorInmueble.toString(),
      onSaved: (value) {
        valorInmueble = int.parse(value);
      },
      validator: validarCampoNumerico,
      keyboardType: TextInputType.number,
      decoration: inputDecoration(label, hint),
    );
  }
}
