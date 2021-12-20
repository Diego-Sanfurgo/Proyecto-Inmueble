import 'package:flutter/material.dart';
import 'package:formulario_4/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: getRoutes(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.deepPurple[50],
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blueGrey[50],
            backgroundColor: Colors.deepPurple[600],
            elevation: 10.0,
            selectedLabelStyle: TextStyle(color: Colors.white),
            unselectedLabelStyle: TextStyle(color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 25),
            backgroundColor: Colors.deepPurple[600],
          ),
        ));
  }
}
