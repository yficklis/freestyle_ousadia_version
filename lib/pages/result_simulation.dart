import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultSimulation extends StatelessWidget {

  final dynamic simulationData;
  ResultSimulation({Key key, @required this.simulationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.lightBlueAccent),
        centerTitle: true,
        backgroundColor: Colors.grey[50],
        elevation: 5.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Container(color: Colors.grey[50], height: 0.0,),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0, bottom: 15.0),
          child: Center(
              child: Image.asset('assets/logo2.png')
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Image.network(
                  "https://raw.githubusercontent.com/devefy/Flutter-Login-Page-UI/master/assets/image_02.png"),
            ],
          ),
          Center(
            child: new Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              width: ScreenUtil.getInstance().setWidth(700),
              height: ScreenUtil.getInstance().setHeight(1334),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: simulationData.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(00.0),
                  child: Center(
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      simulationData[index]['NomeProposta'] +
                                          " " +
                                          (index + 1).toString(),
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold)),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0.0, right: 7.5, top: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Valor Financiado",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold)),
                                      Text("R\$ "+simulationData[index]['ValorFinanciado'],
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[800])),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0.0, right: 7.5, top: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Primeira Parcela",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold)),
                                      Text("R\$ "+simulationData[index]['PrimeiraParcela'],
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[800])),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 5.0, right: 7.5, top: 5.0, bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Última Parcela",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold)),
                                      Text("R\$ "+simulationData[index]['UltimaParcela'],
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[800])),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 0.0, right: 7.5, top: 5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Juros (Percentual a.a.)",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.bold)),
                                        Text(simulationData[index]['JurosEfetivos'] +"%",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[800])),
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0.0, right: 7.5, top: 5.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("CET (Percentual a.a.)",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            simulationData[index]
                                            ['CustoEfetivoAno']+"%",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[800])),
                                      ]),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0.0, right: 7.5, top: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Observações",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold)),
                                      Text(simulationData[index]['Observacao'],
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[800])),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(height: 50.0, color: Colors.black,)
                          ],
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
