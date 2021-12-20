import 'package:flutter/material.dart';
import 'package:formulario_4/Widgets/customButton_widget.dart';
import 'package:formulario_4/models/tipoInmueble_model.dart';
import 'package:formulario_4/providers/tipo_inmueble_pvdr.dart';
import 'package:formulario_4/utils/utils.dart';

class ABMTipoInmueble extends StatefulWidget {
  @override
  _ABMTipoInmuebleState createState() => _ABMTipoInmuebleState();
}

class _ABMTipoInmuebleState extends State<ABMTipoInmueble> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final tipoInmuebleProvider = new TipoInmuebleProvider();
  TipoInmuebleModel tipoInmueble = new TipoInmuebleModel();

  String valorInicial = '';
  bool _habilitado = false;

  // bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Tipos de inmueble'),
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
          hintText: 'Nuevo tipo de inmueble', labelText: 'Tipo de inmueble'),
      onSaved: (value) => tipoInmueble.nombre = value,
      validator: (value) {
        if (value.length < 4) {
          return 'Ingrese un tipo de inmueble válido';
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
        CustomButton(
          color: Colors.blue,
          iconData: Icons.save_alt_rounded,
          labelText: 'Guardar',
          onPress: (_habilitado) ? null : _submit,
        ),
        CustomButton(
          color: Colors.green,
          iconData: Icons.autorenew_rounded,
          labelText: 'Editar',
          onPress: (_habilitado) ? _submit : null,
        ),
      ],
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if (tipoInmueble.id == null) {
      tipoInmuebleProvider.crearTipoInmueble(tipoInmueble);
      mostrarSnackbar('Tipo de inmueble guardado', scaffoldKey);
    } else {
      tipoInmuebleProvider.editarTipoInmueble(tipoInmueble);
      mostrarSnackbar('Tipo de inmueble modificado', scaffoldKey);
    }

    setState(() {
      _habilitado = false;
      valorInicial = '';
    });

    formKey.currentState.reset();
  }

  /* void _submitEdit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    tipoInmuebleProvider.editarTipoInmueble(tipoInmueble);
    mostrarSnackbar('Tipo de inmueble modificado', scaffoldKey);
    _habilitado = false;
    setState(() {
      valorInicial = '';
    });
    formKey.currentState.reset();
  } */

  Widget _crearListado() {
    return FutureBuilder(
      future: tipoInmuebleProvider.cargarTipos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TipoInmuebleModel>> snapshot) {
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

  Widget _crearTile(TipoInmuebleModel tipo) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
              trailing: IconButton(
                  icon: Icon(Icons.cancel_sharp, color: Colors.black54),
                  onPressed: () {
                    tipoInmuebleProvider.borrarTipo(tipo.id);
                    setState(() {});
                  }),
              tileColor: Colors.blueGrey[100],
              title: Text(tipo.nombre ?? 'Default'),
              subtitle: (Text('ID: ${tipo.id}')),
              onTap: () {
                valorInicial = tipo.nombre;
                tipoInmueble = tipo;
                _habilitado = true;

                setState(() {});
              }),
        ),
        Divider(),
      ],
    );
  }
}
