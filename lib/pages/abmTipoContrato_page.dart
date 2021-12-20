import 'package:flutter/material.dart';
import 'package:formulario_4/models/tipoContrato_model.dart';
import 'package:formulario_4/utils/utils.dart';

import 'package:formulario_4/models/tipoInmueble_model.dart';
import 'package:formulario_4/providers/tipo_contrato_provider.dart';

class ABMTipoContrato extends StatefulWidget {
  @override
  _ABMTipoContrato createState() => _ABMTipoContrato();
}

class _ABMTipoContrato extends State<ABMTipoContrato> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final tipoContratoProvider = new TipoContratoProvider();
  TipoContratoModel tipoContrato = new TipoContratoModel();

  String valorInicial = '';
  bool _habilitado = false;

  // bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Tipos de contrato'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _crearCampoNombre(),
                Divider(),
                _crearBotones(),
                Divider(),
                _crearListado(),
              ],
            )),
      ),
    );
  }

  Widget _crearCampoNombre() {
    return TextFormField(
      initialValue: valorInicial,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          hintText: 'Nuevo tipo de contrato', labelText: 'Tipo de contrato'),
      onSaved: (value) => tipoContrato.nombre = value,
      validator: (value) {
        if (value.length < 4) {
          return 'Ingrese un tipo de contrato válido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 120,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return Colors.blue;
              }),
            ),
            icon: Icon(Icons.save_alt_rounded),
            label: Text('Guardar'),
            onPressed: (_habilitado) ? null : _submit,
          ),
        ),
        Container(
          width: 120,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                return getColor(states, Colors.green);
              }),
            ),
            icon: Icon(Icons.autorenew_rounded, color: Colors.white),
            label: Text('Editar', style: TextStyle(color: Colors.white)),
            onPressed: (_habilitado) ? _submit : null,
          ),
        ),
      ],
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if (tipoContrato.id == null) {
      tipoContratoProvider.crearTipoContrato(tipoContrato);
      mostrarSnackbar('Tipo de inmueble guardado', scaffoldKey);
    } else {
      tipoContratoProvider.editarTipoContrato(tipoContrato);
      mostrarSnackbar('Tipo de inmueble modificado', scaffoldKey);
    }

    setState(() {
      _habilitado = false;
      valorInicial = '';
    });

    tipoContrato = TipoContratoModel();
    formKey.currentState.reset();
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: tipoContratoProvider.cargarTipoContratos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TipoContratoModel>> snapshot) {
        if (snapshot.hasData) {
          final tipos = snapshot.data;
          return Expanded(
              child: ListView.builder(
            itemCount: tipos.length,
            itemBuilder: (context, i) => _crearTile(tipos[i]),
          ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearTile(TipoContratoModel tipo) {
    return Column(
      children: [
        ListTile(
            trailing: IconButton(
                icon: Icon(Icons.cancel_sharp, color: Colors.black54),
                onPressed: () {
                  tipoContratoProvider.borrarTipoContrato(tipo.id);
                  setState(() {});
                }),
            tileColor: Colors.blueGrey[100],
            title: Text('Contrato de ${tipo.nombre}' ?? 'Default'),
            subtitle: (Text(tipo.id)),
            onTap: () {
              // valorInicial = '';
              formKey.currentState.reset();

              // valorInicial = tipo.nombre;
              tipoContrato = tipo;
              _habilitado = true;

              setState(() {});
            }),
        Divider(),
      ],
    );
  }
}
