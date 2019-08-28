import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String result = "Informe os seus dados acima";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      setState(() {
        result = "Informe os seus dados acima";
        _formkey = GlobalKey<FormState>();
      });
    });
  }

  void _calcula() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        result = "-> Seu IMC é de ${imc.toStringAsPrecision(3)}.\n"
            "\n-> Nível de magreza detectado!\n"
            "\n-> Nível de obesidade 0.\n"
            "\n-> Procure um nutricionista.\n"
            "\n-> Melhore a sua dieta.";
      } else if (imc >= 18.5 && imc <= 24.9) {
        result = "-> Seu IMC é de ${imc.toStringAsPrecision(3)}.\n"
            "\n-> Seu imc encontra-se no ideal!\n"
            "\n-> Nível de obesidade 0.\n"
            "\n-> Ótimo,siga com a sua dieta.";
      } else if (imc >= 25.0 && imc <= 29.9) {
        result = "-> Seu IMC é de ${imc.toStringAsPrecision(3)}.\n."
            "\n-> Você esta com SOBREPESO!\n"
            "\n-> Nível de obesidade I.\n"
            "\n-> Fique alerta!\n"
            "\n-> Gordices apenas nos finais de semana.";
      } else if (imc >= 30.0 && imc <= 39.9) {
        result = "-> Seu IMC é de ${imc.toStringAsPrecision(3)}.\n"
            "\n-> Nível de obesidade II\n. "
            "\n-> PERIGO! Cuide-se!.";
      } else {
        result = "-> Seu IMC é de ${imc.toStringAsPrecision(3)}.\n"
            "\n-> Sua obesidade esta avançada!\n"
            " \n-> Alerta VERMELHO! Busque ajuda!\n"
            "\n-> Pare tudo o que esta fazendo e procure um endocrinologista, psicólogo, nutricionista e/ou um personal trainer.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: 35,
              ),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person, size: 150, color: Colors.red),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira o seu peso!";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso em quilogramas(ex: 72)",
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        )),
                    controller: weightController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira a sua altura!";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura em centímetros(ex:185)",
                        labelStyle: TextStyle(
                            color: Colors.red, fontStyle: FontStyle.italic)),
                    controller: heightController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              _calcula();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          color: Colors.red,
                        ),
                      )),
                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
