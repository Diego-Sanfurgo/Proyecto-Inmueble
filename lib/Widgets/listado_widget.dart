/* import 'package:flutter/material.dart';

class Listado extends StatelessWidget {
  Future<List> future;
  void Function() onPressed;
  void Function() onTap;
  String name;
  String id;

  Listado({@required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          final elementos = snapshot.data;
          return Expanded(
              child: ListView.builder(
            itemCount: elementos.length,
            itemBuilder: (context, i) => _crearTile(elementos[i]),
          ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearTile(dynamic elemento) {
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
                    paisProvider.borrarPais(elemento.id);
                    setState(() {});
                  }),
              tileColor: Colors.blueGrey[100],
              title: Text(elemento.nombre ?? 'Default'),
              subtitle: (Text('ID: ${elemento.id}')),
              onTap: () {
                valorInicial = elemento.nombre;
                paisModel = elemento;
                _habilitado = true;

                setState(() {});
              }),
        ),
        Divider(),
      ],
    );
  }
}
 */