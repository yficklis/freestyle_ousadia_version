import 'package:flutter/material.dart';
import 'package:freestyle_ousadia_version/routes/router.dart';

void main(){
  NavigationRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login',
      onGenerateRoute: NavigationRouter.router.generator,
    );
  }
}
