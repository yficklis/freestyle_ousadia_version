import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Refinancing extends StatefulWidget {

  bool is_partner;
  String token;

  Refinancing({Key key, this.is_partner, this.token}) : super(key: key);

  @override
  _RefinancingState createState() => _RefinancingState();
}

class _RefinancingState extends State<Refinancing> {

  int currStep = 0;

  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var result;
  List citys = [];

  @override
  void initState() {
    _mySteps();
    getCity(35);
  }

  @override
  Widget build(BuildContext context) {
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
                      'state': '35',
                      'date': DateTime(DateTime.now().year - 19),
                      'parcelas': '240'
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
                          if (currStep == 0) {
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
                          } else if (currStep == 14) {
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
                          } else {
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
                    ]),
                  )),
            )
          ],
        )
    );
  }

  List _mySteps() {
    List<Step> steps = [
      new Step(
          title: const Text('Nome do cliente'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "name",
            decoration: InputDecoration(
                hintText: "Digite o nome completo do cliente",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Insira o nome completo do cliente!")
            ],
          )),
      new Step(
          title: const Text('Telefone do cliente'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "phone",
            controller: new MaskedTextController(mask: '(00) 0000-0000'),
            decoration: InputDecoration(
                hintText: "(XX) XXXX-XXXX",
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
          title: const Text('Celular do cliente'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "celphone",
            controller: new MaskedTextController(mask: '(00) 00000-0000'),
            decoration: InputDecoration(
                hintText: "(XX) XXXXX-XXXX",
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
          title: const Text('E-mail do cliente'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "email",
            decoration: InputDecoration(
                hintText: "Digite o e-mail do cliente",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Insira o e-mail do cliente!")
            ],
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
            onChanged: (void val) {
              getCity(_formKey.currentState.fields['state'].currentState.value);
            },
          )),
      new Step(
          title: const Text('Cidade'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: new FormBuilderDropdown(
            attribute: "city",
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Selecione uma cidade!")
            ],
            items: citys
                .map((type) =>
                DropdownMenuItem(value: type, child: Text("$type")))
                .toList(),
          )),
      new Step(
          title: const Text('Valor do imóvel'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "property_value",
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
            attribute: "desired_value",
            controller: new MoneyMaskedTextController(
                decimalSeparator: ',',
                thousandSeparator: '.',
                initialValue: 5000),
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
          title: const Text('Tempo para pagamento (em meses)'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "desired_period",
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
          title: const Text('Renda'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "monthly_income",
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
          title: const Text('Finalidade'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: new FormBuilderDropdown(
            attribute: "goal",
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Selecione à finalidade!")
            ],
            items: ['Residencial', 'Comercial']
                .map((type) =>
                DropdownMenuItem(value: type, child: Text("$type")))
                .toList(),
          )),
      new Step(
          title: const Text('Financiado?'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: new FormBuilderDropdown(
            attribute: "financed",
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Selecione uma das opções!")
            ],
            items: ['Sim', 'Não']
                .map((type) =>
                DropdownMenuItem(value: type, child: Text("$type")))
                .toList(),
          )),
      new Step(
          title: const Text('Sugestões'),
          isActive: true,
          state: StepState.indexed,
          content: new FormBuilderTextField(
            attribute: "sugestions",
            decoration: InputDecoration(),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, preencha o campo!")
            ],
          )),
      new Step(
          title: const Text('Forma de contato preferencial:'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: new FormBuilderDropdown(
            attribute: "contact_preferency",
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            validators: [
              FormBuilderValidators.required(
                  errorText: "Por favor, Selecione uma das opções!")
            ],
            items: contatc_items.entries
                .map<DropdownMenuItem<String>>(
                    (MapEntry<String, String> e) => DropdownMenuItem<String>(
                  value: e.key,
                  child: Text(e.value),
                ))
                .toList(),
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

  Future getCity(state) async {
    print(state);
    http.Response response = await http.get(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$state/municipios');
    var result = json.decode(response.body);
    citys = [];
    for (var index in result) {
      if (index != null) {
        citys.add(index['nome']);
      }
    }
    setState(() {
      _formKey.currentState.fields['city'].currentState.reset();
      citys = citys;
    });
  }

  void _submitDetails() async {
    if (_formKey.currentState.validate()) {
      await newLeadFin();
      print(result);
      if (result == 200) {
        _showDialogSucess();
      } else {
        _showDialogError();
      }
    }
  }

  Future newLeadFin() async {
    var params = _buildJson();
    http.Response response = await http.post(
        'https://documentos.melhortaxa.com.br:1443/v1/lead/financiamento',
        body: params,
        headers: {
          'x-access-token': widget.token,
          'Accept': 'application/json'
        });
    result = response.statusCode;
  }

  String _buildJson() {
    var type = "REFIN";
    var property_value =
        _formKey.currentState.fields['property_value'].currentState.value;
    var desired_value =
        _formKey.currentState.fields['desired_value'].currentState.value;
    var desired_period =
        _formKey.currentState.fields['desired_period'].currentState.value;
    var contact_preferency =
        _formKey.currentState.fields['contact_preferency'].currentState.value;
    var email = _formKey.currentState.fields['email'].currentState.value;
    var name = _formKey.currentState.fields['name'].currentState.value;
    var phone = _formKey.currentState.fields['phone'].currentState.value;
    var celphone = _formKey.currentState.fields['celphone'].currentState.value;
    var monthly_income =
        _formKey.currentState.fields['monthly_income'].currentState.value;
    var goal = _formKey.currentState.fields['goal'].currentState.value;
    var sugestions =
        _formKey.currentState.fields['sugestions'].currentState.value;
    var financed = (_formKey.currentState.fields['financed'].currentState.value.toString() == 'Sim') ? 1 : 0;

    String json =
        '{"type" : "$type","property_value" : "$property_value","desired_value" : "$desired_value","desired_period" : "$desired_period","contact_preferency" : "$contact_preferency","email" : "$email","name" : "$name","phone" : "$phone","celphone" : "$celphone", "monthly_income" : "$monthly_income", "goal" : "$goal","sugestions" : "$sugestions","financed" : "$financed"}';
    return json;
  }

  void _showDialogSucess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Solicitação realizada com sucesso."),
          actions: <Widget>[
            new FlatButton(
//                onPressed: () {
//                  Navigator.pushReplacementNamed(context, 'home/');
//                },
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Fechar"))
          ],
        );
      },
    );
    result = null;
    _formKey = GlobalKey<FormBuilderState>();
  }

  void _showDialogError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
              "Não foi possivel realizar a sua solicitação, por favor tente novamente."),
          content: new Text("Verifique se os dados preenchidos"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Fechar"))
          ],
        );
      },
    );
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

final contatc_items = {
  "1": 'Telefone fixo',
  "2": 'Celular',
  "3": 'Whatsapp',
  "4": 'E-mail',
  "5": 'Estou apenas Simulando'
};
