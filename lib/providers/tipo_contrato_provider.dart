import 'dart:convert';

import 'package:formulario_4/models/tipoContrato_model.dart';
import 'package:http/http.dart' as http;

class TipoContratoProvider {
  final _urlFire = 'https://formulario-consensus-default-rtdb.firebaseio.com';

  Future<bool> crearTipoContrato(TipoContratoModel tipoContrato) async {
    final url = '$_urlFire/TipoContrato.json';
    final resp =
        await http.post(url, body: tipoContratoModelToJson(tipoContrato));
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;
  }

  Future<bool> editarTipoContrato(TipoContratoModel tipoContrato) async {
    final url = '$_urlFire/TipoContrato/${tipoContrato.id}.json';
    final resp =
        await http.put(url, body: tipoContratoModelToJson(tipoContrato));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<TipoContratoModel>> cargarTipoContratos() async {
    final url = '$_urlFire/TipoContrato.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<TipoContratoModel> tipos = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, tipo) {
      final tipoTemp = TipoContratoModel.fromJson(tipo);

      tipoTemp.id = id;

      tipos.add(tipoTemp);
    });

    return tipos;
  }

  Future<int> borrarTipoContrato(String id) async {
    final url = '$_urlFire/TipoContrato/$id.json';
    final resp = await http.delete(url);

    //Si hay error, lo trae acá
    print(resp.body);

    return 1;
  }
}
