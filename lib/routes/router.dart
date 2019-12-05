import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

// pages //

import 'package:freestyle_ousadia_version/pages/login.dart';
import 'package:freestyle_ousadia_version/pages/home.dart';

class NavigationRouter{
  static String token;
  static bool is_partner;
  static Router router = Router();

  static Handler _loginHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Login());
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Home(is_partner: is_partner, token: token));

  static void setupRouter(){
    router.define('login', handler: _loginHandler);
    router.define('home/', handler: _homeHandler);
  }
}