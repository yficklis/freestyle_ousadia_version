import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


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
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: new FormBuilder(
                  key: _formKey,
                  autovalidate: true,
                  initialValue: {
                    'type': 'Para comprar um imóvel',
                  },
                  child: new ListView(children: <Widget>[

                    new Stepper(
                      physics: ScrollPhysics(),
                      steps: _mySteps(),
                      type: StepperType.vertical,
                      currentStep: this.currStep,
                      onStepContinue: () {
                        setState(() {
                          if (currStep < _mySteps().length - 1) {
                            currStep = currStep + 1;
                          } else {
                            currStep = 0;
                          }
                        });
                      },
                      onStepCancel: () {
                        setState(() {
                          if (currStep > 0) {
                            currStep = currStep - 1;
                          } else {
                            currStep = 0;
                          }
                        });
                      },
                      onStepTapped: (step) {
                        setState(() {
                          currStep = step;
                        });
                      },
                      controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) {
                        if(currStep == 0){
                          return Row(
                            children: <Widget>[
                              FlatButton(
                                onPressed: _submitDetails,
                                color: Colors.lightBlueAccent,
                                child: Text(
                                  'Próximo',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              FlatButton(
                                child: null,
                                onPressed: onStepCancel,
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: <Widget>[
                            FlatButton(
                              child: Text("Próximo"),
                              onPressed: onStepContinue,
                            ),
                            FlatButton(
                              child: Text("Voltar"),
                              onPressed: onStepCancel,
                            ),
                          ],
                        );
                      },
                    ),

                  ]),
                )),
          )
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
//          new FormBuilderDropdown(
//            onChanged: (void val){
//              if(_formKey.currentState.fields['type'].currentState.value.toString() == "Para comprar um imóvel"){
//                print("COMPRAR");
//              }
//              else{
//                print('REFINANCIAR');
//              }
//            } ,
//            attribute: "type",
//            decoration: InputDecoration(
//              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
//            ),
//            validators: [
//              FormBuilderValidators.required(
//                  errorText: "Por favor, Selecione um tipo de empréstimo!")
//            ],
//            items: ['Para comprar um imóvel', 'Imóvel de garantia']
//                .map(
//                    (type) => DropdownMenuItem(value: type, child: Text("$type")))
//                .toList(),
//          )
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
