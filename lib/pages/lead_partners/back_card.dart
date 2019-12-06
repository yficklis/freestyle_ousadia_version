import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:intl/intl.dart';

class BackCard extends StatefulWidget {
  dynamic lead;
  BackCard({Key key, this.lead}) : super(key: key);

  @override
  _BackCardState createState() => _BackCardState();
}

class _BackCardState extends State<BackCard> {

  var _settings = MoneyFormatterSettings(
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolAndNumberSeparator: ' ',
    fractionDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    FlutterMoneyFormatter property_value = FlutterMoneyFormatter(amount: widget.lead['property_value'], settings: _settings);
    FlutterMoneyFormatter partner_comission_min = FlutterMoneyFormatter(amount: widget.lead['partner_comission_min'], settings: _settings);
    FlutterMoneyFormatter partner_comission_max = FlutterMoneyFormatter(amount: widget.lead['partner_comission_max'], settings: _settings);
    FlutterMoneyFormatter desired_value = FlutterMoneyFormatter(amount: widget.lead['desired_value']);
    return Material(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0
            ),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height:
              ScreenUtil.getInstance().setWidth(180),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      leading: Container(
                        width: ScreenUtil.getInstance()
                            .setWidth(80),
                        height: ScreenUtil.getInstance()
                            .setWidth(80),
                        child: Icon(Icons.monetization_on, color: Colors.white),
                      ),
                      title: Text(widget.lead['name'],
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(property_value.output.nonSymbol,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(92, 192, 208, 82),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(child: Icon(Icons.phone)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    widget.lead['phone'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(child: Icon(Icons.phone_android)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    widget.lead['celphone'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(child: Icon(Icons.location_city)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    widget.lead['city'] +" ("+widget.lead['state']+")",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(child: Icon(Icons.undo )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    'R\$ '+ partner_comission_min.output.nonSymbol +' até R\$ '+partner_comission_max.output.nonSymbol ,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(child: Icon(Icons.attach_money )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    'R\$ '+desired_value.output.nonSymbol,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(child: Icon(Icons.timer )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    widget.lead['desired_period'] + ' meses',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
