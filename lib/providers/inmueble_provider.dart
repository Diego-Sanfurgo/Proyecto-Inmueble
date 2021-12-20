import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:formulario_4/models/inmueble_model.dart';

class InmuebleProvider {
  final _urlFire = 'https://formulario-consensus-default-rtdb.firebaseio.com';

  Future<bool> crearInmueble(InmuebleModel inmueble) async {
    final url = '$_urlFire/Inmueble.json';
    final resp = await http.post(url, body: inmuebleModelToJson(inmueble));
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;
  }

  Future<bool> editarInmueble(InmuebleModel inmueble) async {
    final url = '$_urlFire/Inmueble/${inmueble.id}.json';
    final resp = await http.put(url, body: inmuebleModelToJson(inmueble));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<InmuebleModel>> cargarInmuebles() async {
    final url = '$_urlFire/Inmueble.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<InmuebleModel> inmuebles = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, inmueble) {
      final inmuebleTemp = InmuebleModel.fromJson(inmueble);

      inmuebleTemp.id = id;

      inmuebles.add(inmuebleTemp);
    });

    return inmuebles;
  }

  Future<List<InmuebleModel>> inmueblePorTipo(String tipo) async {
    if (tipo == 'default') return cargarInmuebles();

    final url = '$_urlFire/Inmueble.json?orderBy="tipoId"&equalTo="$tipo"';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<InmuebleModel> inmuebles = [];

    if (decodedData == null) return [];
    decodedData.forEach((id, inmueble) {
      final inmuebleTemp = InmuebleModel.fromJson(inmueble);
      inmuebleTemp.id = id;
      inmuebles.add(inmuebleTemp);
    });

    return inmuebles;
  }

  Future<int> borrarInmueble(String id) async {
    final url = '$_urlFire/Inmueble/$id.json';
    final resp = await http.delete(url);

    //Si hay error, lo trae acá
    print(resp.body);

    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/diego-sanfurgo/image/upload?upload_preset=qcunrfs6');

    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salió mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}
