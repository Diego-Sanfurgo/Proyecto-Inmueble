import 'package:flutter/material.dart';
import 'package:formulario_4/models/tipoInmueble_model.dart';
import 'package:formulario_4/providers/tipo_inmueble_pvdr.dart';

class TipoDropdown extends StatelessWidget {
  void Function(dynamic) change;
  String value;

  TipoDropdown({@required this.change, @required this.value});

  @override
  Widget build(BuildContext context) {
    final tipoInmuebleProvider = new TipoInmuebleProvider();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: 250,
      child: FutureBuilder(
        future: tipoInmuebleProvider.cargarTipos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TipoInmuebleModel>> snapshot) {
          if (snapshot.hasData) {
            final List<TipoInmuebleModel> listaTipos = snapshot.data;
            return Container(
                height: 50,
                child: DropdownButton(
                  hint: Text('Tipo de inmueble'),
                  value: value,
                  onChanged: change,
                  items: listaTipos
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e.nombre),
                            value: e.nombre,
                          ))
                      .toList(),
                ));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
