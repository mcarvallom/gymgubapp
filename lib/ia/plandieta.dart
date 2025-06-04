import 'dart:convert';
import 'package:app_movil/backend/supabase_config.dart';
import 'package:http/http.dart' as http;

Future<void> generarPlanDieta() async {
  final url = Uri.parse('https://xjrxihpqoqmecetwpaua.supabase.co/functions/v1/dieta');
  final userId = SupabaseConfig.client.auth.currentUser?.id;
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqcnhpaHBxb3FtZWNldHdwYXVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxNzQ5NDcsImV4cCI6MjA1Nzc1MDk0N30.13n-n8dm8sll0HwYll_8w8JQy-hQGD0-SBQ75iRY5wE',
  };
  final user = await SupabaseConfig.client
      .from('usuario')
      .select('''id_usuario,objetivoDieta,edad,peso,estatura''')
      .eq('id_usuario', userId!)
      .single();
      
  final body = jsonEncode({
    'objetivo': user['objetivoDieta'],
    'edad': user['edad'],
    'peso': user['peso'],
    'altura': user['estatura'],
    'id_usuario': user['id_usuario'],
    'nivelActividad': 'moderado',
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Respuesta del modelo: ${data}');
  } else {
    print('Error: ${response.statusCode}');
    print(response.body);
  }
}
