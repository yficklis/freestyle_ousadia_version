import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:freestyle_ousadia_version/pages/lead_partners/back_card.dart';
import 'package:freestyle_ousadia_version/pages/lead_partners/front_card.dart';
import 'package:freestyle_ousadia_version/pages/loading/load.dart';

//imports to make request//
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:intl/intl.dart';

class MyIndications extends StatefulWidget {
  bool is_partner;
  String token;
  MyIndications({Key key, this.is_partner, this.token}) : super(key: key);

  @override
  _MyIndicationsState createState() => _MyIndicationsState();
}

class _MyIndicationsState extends State<MyIndications> {
  List leadData = [];
  dynamic data;
  var _initpage = Load();
  var _settings = MoneyFormatterSettings(
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolAndNumberSeparator: ' ',
    fractionDigits: 2,
  );

  @override
  void initState()  {
    super.initState();
    getData();
  }

  Future getData() async {
    var url = "https://documentos.melhortaxa.com.br:1443/v1/lead/partner";
    http.Response response = await http.get('$url', headers: {
      'x-access-token': widget.token,
      'Accept': 'application/json'
    });

    setState(() {
      data = json.decode(response.body);
      for (var index in data['details']) {
        if (index != null) {
          leadData.add(index);
        }
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
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
              Image.asset('assets/image_02.png'),
            ],
          ),
          Center(
            child: _buildChild(),
          )
        ],
      ),
    );
  }


  Widget _buildChild() {
    if (leadData.length == 0) {
      return Load();
    }else{
      return Cards();
    }
  }


  Widget Cards(){
    return Container(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: leadData.length,
        itemBuilder: (BuildContext context, int index) => Container(
//            color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: Center(
                    child: Container(
//                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
//                                height: MediaQuery.of(context).size.width,
                      height: ScreenUtil.getInstance().setWidth(720),
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: FrontCard(lead: leadData[index]),
                        back: BackCard(lead: leadData[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


