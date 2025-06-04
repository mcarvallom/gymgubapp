import 'package:app_movil/backend/supabase_config.dart';
import 'package:app_movil/ia/php_api_service.dart';

Future<void> generarPlanDieta() async {
  try {
    final userId = SupabaseConfig.client.auth.currentUser?.id;

    // Obtener datos del usuario
    final user = await SupabaseConfig.client
        .from('usuario')
        .select('''
          id_usuario,
          objetivoEjercicio,
          nivel_usuario,
          genero,
          peso,
          estatura,
          peso_ideal,
          nivel_usuario,
          restriccion_fisica
        ''')
        .eq('id_usuario', userId!)
        .single();

    // Asegúrate de que nivel_usuario no sea nulo
    final nivel = user['nivel_usuario'] ?? 'Inicial'; // valor por defecto si viene nulo
    final genero = user['genero']?? 1;
    String sexo = 'Otro';
    if(genero==1){
      sexo = 'Masculino';
    }
    else if(genero == 2){
      sexo = 'Femenino';
    }
    else{
      sexo ='No binario';
    }
    // Llamar al servicio PHP
    final response = await PhpApiService.generarPlanEjercicio(
      idUsuario: user['id_usuario'],
      objetivo: user['objetivoEjercicio'],
      pesoActual: user['peso'],
      sexo: sexo,
      diasSemana: 4,
      disponibilidadMinutos: 45,
      pesoIdeal: user['peso_ideal'],
      restricciones: user['restriccion_fisica'], 
      altura: user['estatura'], 
      nivel: user['nivel_usuario'],
    );

    print('Plan generado con éxito: ${response['plan_id']}');
    print('Enfoque: ${response['enfoque']}');

  } catch (e) {
    print('Error al generar plan de dieta: $e');
  }
}
