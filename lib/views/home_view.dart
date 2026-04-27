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
    double? valor = double.tryParse(inputController.text);

    if (valor == null) {
      setState(() {
        resultado = "Ingrese un número válido";
      });
      return;
    }

    Temperatura? temp = await api.convertir(valor);

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
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: inputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Celsius",
                  hintText: "Ej: 25",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: convertir,
                child: Text(
                  "Convertir",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              SizedBox(height: 20),

              Text(
                resultado.isEmpty ? "" : "Resultado: $resultado",
                style: TextStyle(
                  fontSize: 22,
                  color: resultado.contains("Error") ||
                          resultado.contains("Ingrese")
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}