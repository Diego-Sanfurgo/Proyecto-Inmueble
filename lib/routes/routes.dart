import 'package:flutter/material.dart';
import 'package:formulario_4/pages/abmInmueble_page.dart';
import 'package:formulario_4/pages/abmPais_page.dart';
import 'package:formulario_4/pages/abmTipoContrato_page.dart';
import 'package:formulario_4/pages/abmTipo_page.dart';
import 'package:formulario_4/pages/admin_page.dart';
import 'package:formulario_4/pages/home_page.dart';
import 'package:formulario_4/pages/inmuebles_filtrados.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'home': (_) => HomePage(),
    'abm_inmueble': (_) => ABMInmueble(),
    'abm_tipos_inmueble': (_) => ABMTipoInmueble(),
    'abm_pais': (_) => ABMPais(),
    'inmuebles_filtrados': (_) => InmueblesFiltrados(),
    'admin_page': (_) => AdminPage(),
    'abm_tipos_contrato': (_) => ABMTipoContrato(),
    // 'form': (_) => FormPage(),
    // 'formulario': (_) => FormularioPage(),
    // 'tipo_inmueble': (_) => AddTipoInmueblePage(),
  };
}
