import 'dart:convert';

import 'package:formulario_4/models/tipoInmueble_model.dart';
import 'package:http/http.dart' as http;

class TipoInmuebleProvider {
  final _urlFire = 'https://formulario-consensus-default-rtdb.firebaseio.com';

  Future<bool> crearTipoInmueble(TipoInmuebleModel tipoInmueble) async {
    final url = '$_urlFire/TipoInmueble.json';
    final resp =
        await http.post(url, body: tipoInmuebleModelToJson(tipoInmueble));
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;
  }

  Future<bool> editarTipoInmueble(TipoInmuebleModel tipoInmueble) async {
    final url = '$_urlFire/TipoInmueble/${tipoInmueble.id}.json';
    final resp =
        await http.put(url, body: tipoInmuebleModelToJson(tipoInmueble));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<TipoInmuebleModel>> cargarTipos() async {
    final url = '$_urlFire/TipoInmueble.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<TipoInmuebleModel> tipos = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, tipo) {
      final tipoTemp = TipoInmuebleModel.fromJson(tipo);

      tipoTemp.id = id;

      tipos.add(tipoTemp);
    });

    return tipos;
  }

  Future<int> borrarTipo(String id) async {
    final url = '$_urlFire/TipoInmueble/$id.json';
    final resp = await http.delete(url);

    //Si hay error, lo trae acá
    print(resp.body);

    return 1;
  }
}
