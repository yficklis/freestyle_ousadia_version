import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:validate/validate.dart';  //for validation

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:locales/locales.dart';
import 'package:locales/currency_codes.dart';
import 'package:intl/intl.dart';

import 'package:freestyle_ousadia_version/pages/result_simulation.dart';


class Simulation extends StatefulWidget {
  bool is_partner;
  String token;

  Simulation({Key key, this.is_partner, this.token}) : super(key: key);

  @override
  _SimulationState createState() => _SimulationState();
}

class _SimulationState extends State<Simulation> {

  int currStep = 0;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List simulationData = [];
  List data;

  @override
  void initState() {
    super.initState();
    _mySteps();
  }

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
              child: FormBuilder(
                key: _formKey,
                autovalidate: true,
                initialValue: {
                  'type': 'Para comprar um imóvel',
                  'state': '35',
                  'date': DateTime(DateTime.now().year - 19),
                  'parcelas': '240'
                },
                child: ListView(
                  children: <Widget>[
                    Stepper(
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
                                child: Text("Próximo"),
                                onPressed: onStepContinue,
                              ),
                              FlatButton(
                                child: null,
                                onPressed: onStepCancel,
                              ),
                            ],
                          );
                        }else if(currStep == 7){
                          return Row(
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: _submitDetails,
                                        color: Colors.lightBlueAccent,
                                        child: Text(
                                          'Enviar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              FlatButton(
                                child: Text("Voltar"),
                                onPressed: onStepCancel,
                              ),
                            ],
                          );
                        }
                        else{
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
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitDetails() async {
    if (_formKey.currentState.validate()) {
      await getData();
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ResultSimulation(simulationData: simulationData)));
    }
  }

  Future getData() async {
    var url = _buildUrl();
    http.Response response = await http.get('$url', headers: {
      HttpHeaders.authorizationHeader: "dhsb1nEs7NXJyDAb5DwxDaUhiIL756To"
    });
    setState(() {
      data = json.decode(response.body);
    });
    simulationData = [];
    for (var index in data) {
      if (index != null) {
        simulationData.add(index);
      }
    }
  }

  String _buildUrl() {
    var data = _formKey.currentState.fields['date'].currentState.value;
    var url =
    (_formKey.currentState.fields['type'].currentState.value.toString() ==
        'Para comprar um imóvel')
        ? "https://www.melhortaxa.com.br/api/simulacaofinget/"
        : "https://melhortaxa.com.br/api/simulacaorefinget/";
    var mes = (DateTime.parse(data.toString()).month.toInt() + 1).toString();
    var ano = (DateTime.parse(data.toString()).year).toString();
    var imovel = _formKey.currentState.fields['valorImovel'].currentState.value;
    var fin =
        _formKey.currentState.fields['valorFinanciamento'].currentState.value;
    var renda = _formKey.currentState.fields['rendaMensal'].currentState.value;
    var parcelas = _formKey.currentState.fields['parcelas'].currentState.value;
    var state = items[_formKey.currentState.fields['state'].currentState.value];
    String result = "$url$imovel/$fin/$parcelas/$renda/$mes/$ano/$state/1";
    return result;
  }

  List _mySteps() {
    List<Step> steps = [
      new Step(
          title: const Text('Tipo de empréstimo'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: new FormBuilderDropdown(
            attribute: "type",
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Selecione um tipo de empréstimo!")
            ],
            items: ['Para comprar um imóvel', 'Imóvel de garantia']
                .map((type) =>
                DropdownMenuItem(value: type, child: Text("$type")))
                .toList(),
          )),
      new Step(
          title: const Text('Estado'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderDropdown(
            attribute: "state",
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Insira um Estado!")
            ],
            items: items.entries
                .map<DropdownMenuItem<String>>(
                    (MapEntry<String, String> e) => DropdownMenuItem<String>(
                  value: e.key,
                  child: Text(e.value),
                ))
                .toList(),
          )),
      new Step(
          title: const Text('Data de Nascimento'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderDateTimePicker(
            attribute: "date",
            inputType: InputType.date,
            format: DateFormat('dd/MM/yyyy'),
            firstDate: DateTime(DateTime.now().year - 76),
            lastDate: DateTime(DateTime.now().year - 19),
            initialDate: DateTime(DateTime.now().year - 19),
            decoration: InputDecoration(
                hintText: "01/01/2001",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          )),
      new Step(
          title: const Text('Valor do imóvel'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "valorImovel",
            controller: new MoneyMaskedTextController(
                decimalSeparator: ',',
                thousandSeparator: '.',
                initialValue: 200000),
            decoration: InputDecoration(
                hintText: "R\$ 0,00",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Insira o valor do seu imóvel!")
            ],
            keyboardType: TextInputType.phone,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          )),
      new Step(
          title: const Text('Valor desejado'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "valorFinanciamento",
            controller: new MoneyMaskedTextController(
                decimalSeparator: ',',
                thousandSeparator: '.',
                initialValue: 50000),
            decoration: InputDecoration(
                hintText: "R\$ 0,00",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Insira o valor desejado!")
            ],
            keyboardType: TextInputType.phone,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          )),
      new Step(
          title: const Text('Renda'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "rendaMensal",
            controller: new MoneyMaskedTextController(
                decimalSeparator: ',',
                thousandSeparator: '.',
                initialValue: 5000),
            decoration: InputDecoration(
                hintText: "R\$ 0,00",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Insira o valor da sua renda!")
            ],
            keyboardType: TextInputType.phone,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          )),
      new Step(
          title: const Text('Parcelas'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "parcelas",
            decoration: InputDecoration(
                hintText: "240",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Insira o número de meses!"),
              FormBuilderValidators.numeric(errorText: "Apenas números!"),
              FormBuilderValidators.max(240,
                  errorText: "O número de meses deve ser menor 240")
            ],
            keyboardType: TextInputType.phone,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          )),
      new Step(
        title: const Text("Completo"),
        isActive: true,
        state: StepState.complete,
        content: new Container(),
      )
    ];
    return steps;
  }

}

final items = {
  "12": "AC",
  "27": "AL",
  "13": "AM",
  "16": "AP",
  "29": "BA",
  "23": "CE",
  "53": "DF",
  "32": "ES",
  "52": "GO",
  "21": "MA",
  "51": "MT",
  "50": "MS",
  "31": "MG",
  "15": "PA",
  "25": "PB",
  "41": "PR",
  "26": "PE",
  "22": "PI",
  "33": "RJ",
  "24": "RN",
  "11": "RO",
  "43": "RS",
  "14": "RR",
  "42": "SC",
  "28": "SE",
  "35": "SP",
  "17": "TO"
};
