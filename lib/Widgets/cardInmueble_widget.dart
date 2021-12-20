import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formulario_4/models/inmueble_model.dart';

class CardsInmueble extends StatelessWidget {
  final Future<List<InmuebleModel>> future;

  CardsInmueble({@required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder:
          (BuildContext context, AsyncSnapshot<List<InmuebleModel>> snapshot) {
        if (snapshot.hasData) {
          final inmuebles = snapshot.data;
          return Expanded(
            child: ListView.builder(
                itemCount: inmuebles.length,
                itemBuilder: (_, i) => _crearCard(context, inmuebles[i])),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearCard(BuildContext context, InmuebleModel _inmueble) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, 'abm_inmueble', arguments: _inmueble)
              .then((value) {}),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  (_inmueble.fotoUrl == null)
                      ? Image(image: AssetImage('assets/no-image.png'))
                      : FadeInImage(
                          image: NetworkImage(_inmueble.fotoUrl),
                          placeholder: AssetImage('assets/jar-loading.gif'),
                          height: 300.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  ListTile(
                    title: Text(
                        '${_inmueble.tipoId} - ${_inmueble.ambientes} Ambientes'),
                    subtitle:
                        Text('Antifuedad: ${_inmueble.antiguedad.toString()}'),
                    trailing: FaIcon(FontAwesomeIcons.home),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.transparent, height: 20),
        ],
      ),
    );
  }
}
