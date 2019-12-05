import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freestyle_ousadia_version/pages/financing.dart';
import 'package:freestyle_ousadia_version/pages/indication.dart';
import 'package:freestyle_ousadia_version/pages/my_indications.dart';
import 'package:freestyle_ousadia_version/pages/refinancing.dart';
import 'package:freestyle_ousadia_version/pages/simulation.dart' as Sim;

class Home extends StatefulWidget {

  bool is_partner; String token;
  Home({Key key, this.is_partner, this.token}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  Widget callPage(int currentIndex){
    switch (currentIndex){
      case 0: return MyIndications(token: widget.token, is_partner: widget.is_partner);
      case 2: return Sim.Simulation(token: widget.token, is_partner: widget.is_partner,);
      break;
      case 1: return Financing(token: widget.token, is_partner: widget.is_partner);
      break;
//      case 2: return Refinancing(token: widget.token, is_partner: widget.is_partner);
//      break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
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
      body: callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value){
          _currentIndex = value;
          setState(() {

          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Indicação')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            title: Text('Simulação'),
          )
        ],
      ),
//      endDrawer: Icon(Icons.exit_to_app),
    );
  }
}
