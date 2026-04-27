import 'package:flutter/material.dart';
import '../controllers/api_controller.dart';
import '../models/temperatura.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController inputController = TextEditingController();
  final ApiController api = ApiController();

  String resultado = "";

  void convertir() async {
    if (inputController.text.isEmpty) {
      setState(() {
        resultado = "Ingrese un valor";
      });
      return;
    }

    double celsius = double.parse(inputController.text);

    Temperatura? temp = await api.convertir(celsius);

    if (temp != null) {
      setState(() {
        resultado = "${temp.fahrenheit.toStringAsFixed(2)} °F";
      });
    } else {
      setState(() {
        resultado = "Error al conectar con API";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predicción Celsius → Fahrenheit"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingrese valor en Celsius",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertir,
              child: Text("Predict"),
            ),
            SizedBox(height: 20),
            Text(
              "Resultado: $resultado",
              style: TextStyle(fontSize: 22, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}