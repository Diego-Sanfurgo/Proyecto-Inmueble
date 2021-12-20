import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:formulario_4/Widgets/seccionTile_widget.dart';
import 'package:formulario_4/models/tipoContrato_model.dart';
import 'package:formulario_4/providers/tipo_contrato_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:formulario_4/models/tipoInmueble_model.dart';
import 'package:formulario_4/models/inmueble_model.dart';
import 'package:formulario_4/providers/inmueble_provider.dart';
import 'package:formulario_4/providers/tipo_inmueble_pvdr.dart';
import 'package:formulario_4/utils/utils.dart';

class ABMInmueble extends StatefulWidget {
  @override
  _ABMInmuebleState createState() => _ABMInmuebleState();
}

class _ABMInmuebleState extends State<ABMInmueble> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  InmuebleModel inmueble = new InmuebleModel();
  // PublicacionModel publicacion = new PublicacionModel();

  //Providers
  final inmuebleProvider = new InmuebleProvider();
  final tipoInmuebleProvider = new TipoInmuebleProvider();
  final tipoContratoProvider = new TipoContratoProvider();

  bool _guardando = false;
  bool _permisoBorrar = false;

  File foto;
  Image foto2;

  @override
  Widget build(BuildContext context) {
    final InmuebleModel inmuebleData =
        ModalRoute.of(context).settings.arguments;
    if (inmuebleData != null) {
      inmueble = inmuebleData;
      _permisoBorrar = true;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Inmueble ', style: TextStyle(fontSize: 25)),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            //seleccionar foto de la galería
            onPressed: () => _procesarImagen(ImageSource.gallery),
          ),
        ],
      ),
      body: _bodyABMInmueble(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo_rounded, size: 30),
        //tomar foto
        onPressed: () => _procesarImagen(ImageSource.camera),
      ),
    );
  }

  SingleChildScrollView _bodyABMInmueble() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _mostrarFoto(),
              Divider(color: Colors.black, height: 40),
              //Sección de de datos del inmueble
              CustomTile(name: 'Inmueble', icon: FontAwesomeIcons.home),
              Container(child: _camposInmueble()),
              Divider(height: 22, color: Colors.transparent),
              //Sección de contratación
              /* CustomTile(
                  name: 'Contratación', icon: FontAwesomeIcons.fileContract),
              Container(child: _camposPublicacion()), */
              SizedBox(height: 30),
              _crearBoton(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Column _camposPublicacion() {
    return Column(
      children: [
        _cargarTiposContrato(),
        _crearPrecio(),
        _crearPrecioExpensas(),
      ],
    );
  }

  Column _camposInmueble() {
    return Column(
      children: [
        _cargarTiposInmueble(),
        // _crearDisponible(),
        _crearSuperficie(),
        _crearAmbiente(),
        _crearHabitacion(),
        _crearLavatorio(),
        _crearAntiguedad(),
        _crearMascotas(),
        _crearCochera(),
        _crearCalefaccion(),
      ],
    );
  }

  Widget _crearSuperficie() {
    /* return CustomTextForm(inmueble.superficie,
        label: 'Superficie', hint: 'Superficie en m2'); */
    return TextFormField(
      initialValue:
          (inmueble.superficie != null) ? inmueble.superficie.toString() : '',
      onSaved: (value) {
        inmueble.superficie = int.parse(value);
      },
      validator: validarCampoNumerico,
      keyboardType: TextInputType.number,
      decoration: inputDecoration('Superficie', 'Superficie en m2'),
    );
  }

  Widget _crearAmbiente() {
    return TextFormField(
      initialValue:
          (inmueble.ambientes != null) ? inmueble.ambientes.toString() : '',
      onSaved: (value) {
        inmueble.ambientes = int.parse(value);
      },
      validator: validarCampoNumerico,
      keyboardType: TextInputType.number,
      decoration: inputDecoration('Ambientes', 'Cantidad de ambientes'),
    );
  }

  Widget _crearHabitacion() {
    return TextFormField(
      initialValue: (inmueble.habitaciones != null)
          ? inmueble.habitaciones.toString()
          : '',
      onSaved: (value) {
        inmueble.habitaciones = int.parse(value);
      },
      validator: validarCampoNumerico,
      keyboardType: TextInputType.number,
      decoration: inputDecoration('Habitaciones', 'Cantidad de habitaciones'),
    );
  }

  Widget _crearLavatorio() {
    return TextFormField(
      initialValue:
          (inmueble.lavatorios != null) ? inmueble.lavatorios.toString() : '',
      onSaved: (value) {
        inmueble.lavatorios = int.parse(value);
      },
      validator: validarCampoNumerico,
      keyboardType: TextInputType.number,
      decoration: inputDecoration('Baños', 'Cantidad de baños'),
    );
  }

  Widget _crearAntiguedad() {
    return TextFormField(
        initialValue:
            (inmueble.antiguedad != null) ? inmueble.antiguedad.toString() : '',
        onSaved: (value) {
          inmueble.antiguedad = int.parse(value);
        },
        validator: validarCampoNumerico,
        keyboardType: TextInputType.number,
        decoration: inputDecoration('Antiguedad', 'Años de antiguedad'));
  }

  Widget _crearCochera() {
    return customInmuebleCheckbox(
      'Cochera',
      subtitle: '¿El inmueble tiene cochera?',
      icon: FontAwesomeIcons.car,
      valor: inmueble.cochera,
      onChanged: (value) {
        inmueble.cochera = value;
        setState(() {});
      },
    );
  }

  Widget _crearMascotas() {
    return customInmuebleCheckbox(
      'Mascotas',
      subtitle: '¿Se permiten mascotas?',
      valor: inmueble.mascotas,
      icon: FontAwesomeIcons.paw,
      onChanged: (value) {
        inmueble.mascotas = value;
        setState(() {});
      },
    );
  }

  Widget _crearCalefaccion() {
    return customInmuebleCheckbox(
      'Calefaccion',
      subtitle: '¿El inmueble tiene sistema de calefacción?',
      icon: FontAwesomeIcons.mugHot,
      valor: inmueble.calefaccion,
      onChanged: (value) {
        inmueble.calefaccion = value;
        setState(() {});
      },
    );
  }

  Widget _mostrarFoto() {
    /* List<Widget> listaFotos;
    inmueble.listaFotosUrls.forEach((urlFoto) {
      if (urlFoto != null) {
        listaFotos.add(
          FadeInImage(
            image: NetworkImage(urlFoto),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 300.0,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: (foto != null)
                ? FileImage(foto)
                : AssetImage('assets/no-image.png'),
            height: 300.0,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        );
      }
    }); */
    if (inmueble.fotoUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: NetworkImage(inmueble.fotoUrl),
          placeholder: AssetImage('assets/jar-loading.gif'),
          height: 300.0,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: (foto != null)
              ? FileImage(foto)
              : AssetImage('assets/no-image.png'),
          height: 300.0,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      );
    }
  }

  _procesarImagen(ImageSource origen) async {
    final picker = ImagePicker();
    final _imagePicked = await picker.getImage(source: origen);

    if (_imagePicked != null) {
      foto = File(_imagePicked.path);
      inmueble.fotoUrl = null;
    } else {
      print('No se seleccionó ninguna imagen');
      return Container();
    }
    setState(() {});
  }

  Widget _crearBoton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => getColor(states, Colors.red))),
            onPressed: (_permisoBorrar) ? _submitDelete : null,
            icon: Icon(Icons.cancel_rounded),
            label: Text('Eliminar')),
        RaisedButton.icon(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Colors.deepPurple,
          textColor: Colors.white,
          icon: Icon(Icons.save),
          label: Text('Guardar'),
          onPressed: (_guardando) ? null : _submit,
        ),
      ],
    );
  }

  Widget _cargarTiposInmueble() {
    return Container(
      child: FutureBuilder(
        future: tipoInmuebleProvider.cargarTipos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TipoInmuebleModel>> snapshot) {
          if (snapshot.hasData) {
            final List<TipoInmuebleModel> listaTipos = snapshot.data;
            return Container(
                height: 70, child: _customInmueblesDropdown(listaTipos));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  DropdownButtonFormField<String> _customInmueblesDropdown(
      List<TipoInmuebleModel> listaTipos) {
    return DropdownButtonFormField(
      icon: FaIcon(FontAwesomeIcons.home),
      hint: Text(
        'Tipo de inmueble',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      onSaved: (value) => inmueble.tipoId = value,
      onChanged: (_value) {
        setState(() {});
      },
      validator: (value) {
        if (value == null) {
          return 'Debe elegir un tipo de inmueble';
        } else {
          return null;
        }
      },
      items: listaTipos
          .map((e) => DropdownMenuItem<String>(
                child: Text(e.nombre),
                value: e.nombre,
              ))
          .toList(),
    );
  }

  Widget _cargarTiposContrato() {
    return Container(
      child: FutureBuilder(
        future: tipoContratoProvider.cargarTipoContratos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TipoContratoModel>> snapshot) {
          if (snapshot.hasData) {
            final List<TipoContratoModel> listaTipos = snapshot.data;
            return Container(
                height: 70, child: _customContratoDropdown(listaTipos));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  DropdownButtonFormField<String> _customContratoDropdown(
      List<TipoContratoModel> listaTipos) {
    return DropdownButtonFormField(
      icon: FaIcon(FontAwesomeIcons.fileSignature),
      hint: Text(
        'Tipo de contrato',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      onSaved: (value) => inmueble.tipoContrato = value,
      onChanged: (_value) {
        setState(() {});
      },
      validator: (value) {
        if (value == null) {
          return 'Debe elegir un tipo de contrato';
        } else {
          return null;
        }
      },
      items: listaTipos
          .map((e) => DropdownMenuItem<String>(
                child: Text(e.nombre),
                value: e.nombre,
              ))
          .toList(),
    );
  }

  /* Widget _crearDisponible() {
    return SwitchListTile(
        value: producto.disponible,
        title: Text('Disponible'),
        activeColor: Colors.deepPurple,
        onChanged: (value) {
          setState(() {
            producto.disponible = value;
          });
        });
  } */

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: (inmueble.precio != null) ? inmueble.precio.toString() : '',
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: inputDecoration('Precio', 'Precio'),
      onSaved: (value) => inmueble.precio = double.parse(value),
      validator: (value) {
        if (isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearPrecioExpensas() {
    return TextFormField(
      initialValue: (inmueble.precioExpensas != null)
          ? inmueble.precioExpensas.toString()
          : '',
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: inputDecoration('Precio expensas', 'Precio de las expensas'),
      onSaved: (value) => inmueble.precioExpensas = double.parse(value),
      validator: (value) {
        if (isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  void _submit() async {
    // print('validado: ${!_formKey.currentState.validate()}');
    if (!_formKey.currentState.validate()) return;

    // inmueble.fechaPublicacion = DateTime.now().toLocal();

    _formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      inmueble.fotoUrl = await inmuebleProvider.subirImagen(foto);
    }

    if (inmueble.id == null) {
      inmuebleProvider.crearInmueble(inmueble);
      mostrarSnackbar('Registro creado con éxito', _scaffoldKey);
    } else {
      inmuebleProvider.editarInmueble(inmueble);
      mostrarSnackbar('Registro modificado con éxito', _scaffoldKey);
    }

    setState(() {
      _guardando = false;
    });

    Navigator.pushNamed(context, 'home').then((value) {
      setState(() {});
    });

    // Navigator.pop(context);
  }

  void _submitDelete() async {
    inmuebleProvider.borrarInmueble(inmueble.id);

    mostrarSnackbar('Inmueble eliminado correctamente', _scaffoldKey);

    Navigator.pop(context);
  }
}
