import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void mostrarSnackbar(String mensaje, GlobalKey<ScaffoldState> _scaffoldKey) {
  final snackbar = SnackBar(
    content: Text(mensaje),
    duration: Duration(seconds: 3),
  );

  _scaffoldKey.currentState.showSnackBar(snackbar);
}

Color getColor(Set<MaterialState> states, Color color) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.grey;
  }
  return color;
}

bool isNumeric(String s) {
  if (s.isEmpty) return false;

//Si no se puede parsear retorna null
  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void toggle(bool valor) {
  if (valor == true) {
    valor = false;
  } else {
    valor = true;
  }
}

CheckboxListTile customCheckbox(String titulo, String subtitulo,
    {bool valor, Function(bool) onChanged}) {
  return CheckboxListTile(
    title: Text(titulo),
    subtitle: Text(subtitulo),
    value: valor,
    onChanged: onChanged,
    tileColor: Colors.indigo,
  );
}

CheckboxListTile customInmuebleCheckbox(String title,
    {String subtitle,
    bool valor,
    IconData icon,
    void Function(bool) onChanged}) {
  return CheckboxListTile(
      secondary: FaIcon(icon),
      title: Text(title, style: TextStyle(fontSize: 20)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 16)),
      value: valor,
      onChanged: onChanged);
}

String validarCampoNumerico(value) {
  if (value.isNotEmpty && isNumeric(value)) {
    return null;
  } else {
    return 'Debe completar este campo con numeros';
  }
}

InputDecoration inputDecoration(String label, String hint) {
  return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(fontSize: 26, color: Colors.deepPurple));
}
