import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import screen util//
import 'package:flutter_screenutil/flutter_screenutil.dart';

//imports to make request//
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import router//
import 'package:freestyle_ousadia_version/routes/router.dart';

//import Crypto - used to make base64//
import 'package:cryptoutils/cryptoutils.dart';


class Login extends StatefulWidget {
  bool is_partner; String token;
  Login({Key key, this.is_partner, this.token}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //Form variables//
  final _loginKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Image.asset('assets/image_02.png')
            ],
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              width: ScreenUtil.getInstance().setWidth(700),
              height: ScreenUtil.getInstance().setHeight(650),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/logo2.png')
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
                    Column(
                      children: <Widget>[
                         Form(
                          key: _loginKey,
                          autovalidate: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "E-mail",
                                style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  color: Colors.lightBlue,
                                  fontSize: ScreenUtil.getInstance().setSp(26)
                                ),
                              ),
                              TextFormField(
                                controller: usernameController,
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'Por favor, insira o seu e-mail';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                              Text(
                                  "Senha",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      color: Colors.lightBlueAccent,
                                      fontSize:
                                      ScreenUtil.getInstance().setSp(26)
                                  )
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor, Insira a sua senha!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)
                                ),
                              ),
                              SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          if (_loginKey.currentState
                                              .validate()) {
                                            String username =
                                                usernameController.text;
                                            String password =
                                                passwordController.text;
                                            String token =
                                                "$username:$password";
                                            var bytes = utf8
                                                .encode(token); // make a list
                                            var base64 = CryptoUtils.bytesToBase64(
                                                bytes); // encript code format window.btoa
                                            loginRequest(base64);
                                          }
                                        },
                                        color: Colors.lightBlueAccent,
                                        child: Text(
                                          'Enviar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Make login request//
  Map data;
  Future loginRequest(token) async {

    http.Response response = await http.post(
        'https://documentos.melhortaxa.com.br:1443/v1/auth/login',
        headers: {HttpHeaders.authorizationHeader: "Basic $token"});
    setState(() {
      data = json.decode(response.body);
      if(data['code'] == 200){
        widget.is_partner = data['details']['is_partner'];
        widget.token = data['details']['token'];
        if(widget.is_partner == true && widget.token != null){
          NavigationRouter.token = widget.token;
          NavigationRouter.is_partner = widget.is_partner;
          Navigator.pushReplacementNamed(context, 'home/');
        }
      }else{
        _showDialog();
      }
    });
  }
  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Não foi possivel realizar seu login, por favor tente novamente."),
          content: new Text("Verifique se o usuário ou senha estão corretos"),
          actions: <Widget>[
            new FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: new Text("Fechar")
            )
          ],
        );
      },
    );
  }
}


