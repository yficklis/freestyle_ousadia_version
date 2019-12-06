import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freestyle_ousadia_version/pages/financing.dart';
import 'package:freestyle_ousadia_version/pages/refinancing.dart';


class Indication extends StatefulWidget {

  bool is_partner; String token;
  Indication({Key key, this.is_partner, this.token}) : super(key: key);

  @override
  _IndicationState createState() => _IndicationState();
}

class _IndicationState extends State<Indication> {

  int currStep = 0;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List simulationData = [];
  List data;

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
              Image.asset('assets/image_02.png'),
            ],
          ),
          SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 130.0),
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Financing(is_partner: widget.is_partner, token: widget.token,)));
                        },
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(92, 192, 208, 82),
                          ),
                          child: Center(
                            child: Text(
                              'Financiamento',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Refinancing(is_partner: widget.is_partner, token: widget.token,)));
                        },
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(92, 192, 208, 82)),
                          child: Center(
                            child: Text(
                              'Refinanciamento',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  List _mySteps(){
    List<Step> steps = [

      new Step(
          title: const Text('Tipo de empréstimo'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: FormBuilderRadio(
            attribute: 'type',
            validators: [FormBuilderValidators.required()],
            options: ["Para comprar um imóvel", "Imóvel de garantia"].map((type) => FormBuilderFieldOption(value: type)).toList(growable: false),
            onChanged: (void val){
              if(_formKey.currentState.fields['type'].currentState.value.toString() == "Para comprar um imóvel"){
                print("COMPRAR");
              }
              else{
                print('REFINANCIAR');
              }
            }
          )
      ),
    ];
    return steps;
  }

  void _submitDetails() async {
    if (_formKey.currentState.validate()) {
      if(_formKey.currentState.fields['type'].currentState.value.toString() == "Para comprar um imóvel"){
        Navigator.pushReplacementNamed(context, 'financing/');
      }else{
        Navigator.pushReplacementNamed(context, 'refinancing/');
      }
    }
  }
}
