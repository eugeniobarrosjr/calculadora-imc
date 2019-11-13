import 'package:flutter/material.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController _weightCtrl = TextEditingController();
  TextEditingController _heightCtrl = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe o seus dados";

  void _resetField() {
    _weightCtrl.text = "";
    _heightCtrl.text = "";
    setState(() {
      _infoText = "Informe o seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    double weight = _captureWeight();
    double height = _captureHeight();
    double imc = _calculateIMC(weight, height);
    _showResult(imc);
  }

  double _calculateIMC(double weight, double height) {
    return weight / (height * height);
  }

  double _captureWeight() {
    return double.parse(_weightCtrl.text);
  }

  double _captureHeight() {
    return double.parse(_heightCtrl.text) / 100;
  }

  void _showResult(double imc) {
    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        actions: <Widget>[
          IconButton(
            onPressed: _resetField,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                    size: 120.0,
                  ),
                  TextFormField(
                    controller: _weightCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Peso em (kg)',
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Insira o seu Peso!';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _heightCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Altura em (cm)',
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Insira a sua Altura!';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) calculate();
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        '$_infoText',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
