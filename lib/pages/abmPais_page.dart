import 'package:flutter/material.dart';
import 'package:formulario_4/Widgets/customButton_widget.dart';
import 'package:formulario_4/models/pais_model.dart';
import 'package:formulario_4/providers/pais_provider.dart';
import 'package:formulario_4/utils/utils.dart';

class ABMPais extends StatefulWidget {
  @override
  _ABMPaisState createState() => _ABMPaisState();
}

class _ABMPaisState extends State<ABMPais> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final paisProvider = new PaisProvider();
  PaisModel paisModel = new PaisModel();

  String valorInicial = '';
  bool _habilitado = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Paises'),
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
      decoration:
          InputDecoration(hintText: 'Nuevo país', labelText: 'Nombre del país'),
      onSaved: (value) => paisModel.nombre = value,
      validator: (value) {
        if (value.length < 4) {
          return 'Ingrese un tipo de país válido';
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

        /* Container(
          width: 120,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                return getColor(states, Colors.blue);
              }),
            ),
            icon: Icon(Icons.save_alt_rounded),
            label: Text('Guardar', style: TextStyle(color: Colors.white)),
            onPressed: (_habilitado) ? null : _submit,
          ),
        ), */
        /* Container(
          width: 120,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                return getColor(states, Colors.green);
              }),
            ),
            icon: Icon(Icons.autorenew_rounded, color: Colors.white),
            label: Text(
              'Editar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (_habilitado) ? _submit : null,
          ),
        ), */
      ],
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if (paisModel.id == null) {
      paisProvider.crearPais(paisModel);
      mostrarSnackbar('Nuevo país guardado', scaffoldKey);
    } else {
      paisProvider.editarPais(paisModel);
      mostrarSnackbar('País modificado', scaffoldKey);
    }

    setState(() {
      _habilitado = false;
      valorInicial = '';
    });

    formKey.currentState.reset();
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: paisProvider.cargarPaises(),
      builder: (BuildContext context, AsyncSnapshot<List<PaisModel>> snapshot) {
        if (snapshot.hasData) {
          final paises = snapshot.data;
          return Expanded(
              child: ListView.builder(
            itemCount: paises.length,
            itemBuilder: (context, i) => _crearTile(paises[i]),
          ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearTile(PaisModel _pais) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
              trailing: IconButton(
                  icon: Icon(
                    Icons.cancel_sharp,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    paisProvider.borrarPais(_pais.id);
                    setState(() {});
                  }),
              tileColor: Colors.blueGrey[100],
              title: Text(_pais.nombre ?? 'Default'),
              subtitle: (Text('ID: ${_pais.id}')),
              onTap: () {
                valorInicial = _pais.nombre;
                paisModel = _pais;
                _habilitado = true;

                setState(() {});
              }),
        ),
        Divider(),
      ],
    );
  }
}
