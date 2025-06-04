import 'package:app_movil/ia/planEjercicio.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/backend/supabase_config.dart';

class ObjetivoEjercicioPage extends StatefulWidget {
  const ObjetivoEjercicioPage({super.key});

  @override
  _ObjetivoEjercicioPageState createState() => _ObjetivoEjercicioPageState();
}

class _ObjetivoEjercicioPageState extends State<ObjetivoEjercicioPage> {
  final _formKey = GlobalKey<FormState>();
  final _objetivoEjercicioController = TextEditingController();

  @override
  void dispose() {
    _objetivoEjercicioController.dispose();
    super.dispose(); 
  }

   Future<void> _actualizarObjetivoEjercicio() async {
    if (_formKey.currentState!.validate()) {
      final objetivoEjercicio = _objetivoEjercicioController.text.toUpperCase();
      if (objetivoEjercicio == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, ingrese un objetivo válido.')),
        );
        return;
      }

      final userId = SupabaseConfig.client.auth.currentUser?.id;
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario no autenticado.')),
        );
        return;
      }

      try {
        final response = await SupabaseConfig.client
            .from('usuario')
            .update({'objetivoEjercicio': objetivoEjercicio})
            .eq('id_usuario', userId)
            .select();

          if (response.isNotEmpty) {
         await generarPlanDieta();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Objetivo actualizado exitosamente.')),
          );
          // Verifica si la lista response no está vacía y si el primer elemento contiene 'objetivoEjercicio' nula
          if (response.isNotEmpty && response[0]['objetivoEjercicio'] == null) {
            Navigator.pushReplacementNamed(context, '/objetivoEjercicio');
            return;
          }
          else{
            Navigator.pushReplacementNamed(context, '/inicio');
          }

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar el peso')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inesperado: $error')),
        );
        print('Error inesperado: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeAPP.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: ThemeAPP.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: ThemeAPP.of(context).secondaryText), // Agrega esta línea
        title: Text('Objetivo ejercicio', style: TextStyle(color: ThemeAPP.of(context).secondaryText)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _objetivoEjercicioController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                  decoration: InputDecoration(
                    labelText: 'Objetivo ejercicio', 
                    labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                    filled: true,
                    fillColor: ThemeAPP.of(context).secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su objetivo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeAPP.of(context).primary,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: _actualizarObjetivoEjercicio,
                  child: Text('Listo', style: TextStyle(color: ThemeAPP.of(context).primaryText)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}