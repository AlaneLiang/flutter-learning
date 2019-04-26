import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'pages/home_page/page.dart';
import 'pages/second_page/page.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    println('main');

    final AbstractRoutes routes = HybridRoutes(routes: <AbstractRoutes>[
      PageRoutes(
        pages: <String, Page<Object, dynamic>>{
          'main': HomePage(),
          'second': SecondPage(),
        },
      ),
    ]);

   return MaterialApp(
     home: routes.buildPage('main', null),//主页面
     onGenerateRoute: (RouteSettings settings) {
       return MaterialPageRoute<Object>(builder: (BuildContext context) {
         return routes.buildPage(settings.name, settings.arguments);
       });
     },
   );
  }

}