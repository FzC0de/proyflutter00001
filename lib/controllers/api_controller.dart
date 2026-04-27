import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/temperatura.dart';

class ApiController {
  final String baseUrl = "https://proyectoflask-franzllerena.onrender.com";

  Future<Temperatura?> convertir(double celsius) async {
    final url = Uri.parse('$baseUrl/predict/${celsius.toStringAsFixed(1)}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Temperatura.fromJson(data);
      } else {
        print("Error status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error conexión: $e");
      return null;
    }
  }
}