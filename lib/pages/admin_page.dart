import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text('Administrar'),
      ),
      body: _crearBody(),
    );
  }

  Widget _crearBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _BotonInmueble('ABM Tipos de inmueble',
              route: 'abm_tipos_inmueble',
              leadingIcon: Icons.home_work_outlined),
          Divider(),
          _BotonInmueble('ABM Tipos de contrato',
              route: 'abm_tipos_contrato',
              leadingIcon: Icons.monetization_on_outlined),
          Divider(),
          Container(
            alignment: Alignment.center,
            // height: 500,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          ),
        ],
      ),
    );
  }
}

class _BotonInmueble extends StatelessWidget {
  final String route;
  final IconData leadingIcon;
  final String title;

  const _BotonInmueble(this.title, {this.route, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, route),
        tileColor: Colors.indigo[200],
        leading: Icon(leadingIcon, size: 28, color: Colors.black),
        title: Text(title, style: TextStyle(fontSize: 20, color: Colors.black)),
        trailing: Icon(Icons.keyboard_arrow_right_sharp,
            color: Colors.black, size: 30),
      ),
    );
  }
}
