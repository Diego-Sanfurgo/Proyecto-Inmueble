import 'dart:convert';

import 'package:formulario_4/models/pais_model.dart';
import 'package:http/http.dart' as http;

class PaisProvider {
  final _urlFire = 'https://formulario-consensus-default-rtdb.firebaseio.com';

  Future<bool> crearPais(PaisModel pais) async {
    final url = '$_urlFire/Paises.json';
    final resp = await http.post(url, body: paisModelToJson(pais));
    // final decodedData = json.decode(resp.body);

    return true;
  }

  Future<bool> editarPais(PaisModel pais) async {
    final url = '$_urlFire/Paises/${pais.id}.json';
    final resp = await http.put(url, body: paisModelToJson(pais));
    // final decodedData = json.decode(resp.body);
    return true;
  }

  Future<List<PaisModel>> cargarPaises() async {
    final url = '$_urlFire/Paises.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<PaisModel> paises = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, pais) {
      final paisTemp = PaisModel.fromJson(pais);

      paisTemp.id = id;

      paises.add(paisTemp);
    });

    return paises;
  }

  Future<int> borrarPais(String id) async {
    final url = '$_urlFire/Paises/$id.json';
    final resp = await http.delete(url);

    //Si hay error, lo trae acá
    print(resp.body);

    return 1;
  }
}
