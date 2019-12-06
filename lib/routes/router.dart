import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:freestyle_ousadia_version/pages/financing.dart';

// pages //

import 'package:freestyle_ousadia_version/pages/login.dart';
import 'package:freestyle_ousadia_version/pages/home.dart';
import 'package:freestyle_ousadia_version/pages/refinancing.dart';

class NavigationRouter{
  static String token;
  static bool is_partner;
  static Router router = Router();

  static Handler _loginHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Login());
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Home(is_partner: is_partner, token: token));
  static Handler _refin = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Refinancing(is_partner: is_partner, token: token));
  static Handler _fin = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Financing(is_partner: is_partner, token: token));

  static void setupRouter(){
    router.define('login', handler: _loginHandler);
    router.define('home/', handler: _homeHandler);
    router.define('refin/', handler: _refin);
    router.define('fin/', handler: _fin);
  }
}