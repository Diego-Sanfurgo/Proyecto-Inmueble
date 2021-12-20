import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:formulario_4/Widgets/cardInmueble_widget.dart';
import 'package:formulario_4/Widgets/tiposInmueble_dropdown_widget.dart';
import 'package:formulario_4/models/tipoInmueble_model.dart';
import 'package:formulario_4/models/inmueble_model.dart';
import 'package:formulario_4/providers/inmueble_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TipoInmuebleModel tipoInmueble;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final inmueble = new InmuebleModel();
  final inmuebleProvider = new InmuebleProvider();

  String _filtroTipo;
  Future<List<InmuebleModel>> tipoCarga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Inmuebles', style: TextStyle(fontSize: 25)),
        actions: [
          IconButton(
              icon: Icon(Icons.map_rounded),
              onPressed: () => Navigator.pushNamed(context, 'abm_pais')),
        ],
      ),
      body: _crearBody(),
      drawer: _crearDrawer(context),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: _homeBottomBar(context),
    );
  }

  BottomNavigationBar _homeBottomBar(BuildContext context) {
    return BottomNavigationBar(
      elevation: 12,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, 'admin_page');
            break;
          case 1:
            Navigator.pushNamed(context, 'abm_inmueble').then((value) {
              setState(() {});
            });
            break;
          default:
        }
      },
      iconSize: 26,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.admin_panel_settings_rounded,
              color: Colors.white,
            ),
            label: 'Administrar'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_business_rounded, color: Colors.white),
          label: 'Nuevo inmueble',
        ),
      ],
    );
  }

  Widget _crearDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover),
            ),
          ),
          Container(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(height: 60, child: _cargarTiposInmueble()),
                Container(
                  height: 60,
                  child: TipoDropdown(
                      change: (valor) {
                        _filtroTipo = valor;
                        setState(() {});
                      },
                      value: _filtroTipo),
                )
              ],
            ),
          ),
          OutlinedButton(
            child: Text('Filtrar', style: TextStyle(fontSize: 25)),
            onPressed: () {
              if (_filtroTipo != null) {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'inmuebles_filtrados',
                    arguments: _filtroTipo);

                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _crearBody() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        children: [
          CardsInmueble(future: inmuebleProvider.cargarInmuebles()),
        ],
      ),
    );
  }
}
