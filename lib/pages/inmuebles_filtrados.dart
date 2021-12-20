import 'package:flutter/material.dart';
import 'package:formulario_4/Widgets/cardInmueble_widget.dart';
import 'package:formulario_4/models/inmueble_model.dart';
import 'package:formulario_4/providers/inmueble_provider.dart';

class InmueblesFiltrados extends StatefulWidget {
  @override
  _InmueblesFiltradosState createState() => _InmueblesFiltradosState();
}

class _InmueblesFiltradosState extends State<InmueblesFiltrados> {
  final inmueble = new InmuebleModel();
  final inmuebleProvider = new InmuebleProvider();

  @override
  Widget build(BuildContext context) {
    final tipoInmueble = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: _crearBody(tipoInmueble),
    );
  }

  Widget _crearBody(String tipo) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          // _crearInmuebles(inmueble),
          CardsInmueble(future: inmuebleProvider.inmueblePorTipo(tipo)),
        ],
      ),
    );
  }
}
