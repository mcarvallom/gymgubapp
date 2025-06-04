import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_movil/backend/supabase_config.dart';

class PhpApiService {
  static const String _baseUrl = 'https://gymhub.restify.cl/ia/ia_ejercicio.php';

  static Future<Map<String, dynamic>> generarPlanEjercicio({
    required String idUsuario,
    required String objetivo,
    required double pesoActual,
    required String sexo, // Cambiado a String para coincidir con el PHP
    required int altura, // Añadido campo requerido
    required String nivel, // Cambiado nombre para coincidir con el PHP
    int diasSemana = 3, // Valores por defecto
    int disponibilidadMinutos = 45,
    double? pesoIdeal,
    String? restricciones,
  }) async {
    try {
      final session = SupabaseConfig.client.auth.currentSession;
      final token = session?.accessToken ?? '';

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id_usuario': idUsuario,
          'objetivo': objetivo,
          'peso_actual': pesoActual,
          'sexo': sexo, // Asegúrate que coincida con lo esperado en PHP (M/F)
          'altura': altura, // Campo requerido en tu PHP
          'nivel': nivel, // Nombre cambiado para coincidir con el PHP
          'dias_semana': diasSemana,
          'disponibilidad_minutos': disponibilidadMinutos,
          'peso_ideal': pesoIdeal ?? pesoActual, // Valor por defecto
          'restricciones': restricciones ?? 'ninguna',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        // Verificar si la respuesta contiene un error
        if (responseData.containsKey('error')) {
          throw Exception(responseData['error']);
        }
        
        return responseData;
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(
          'Error ${response.statusCode}: ${errorResponse['error'] ?? response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error al generar plan de ejercicios: $e');
    }
  }
}