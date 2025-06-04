import 'package:app_movil/ia/planEjercicio.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/backend/supabase_config.dart';

class ObjetivoDietaPage extends StatefulWidget {
  const ObjetivoDietaPage({super.key});

  @override
  _ObjetivoDietaPageState createState() => _ObjetivoDietaPageState();
}

class _ObjetivoDietaPageState extends State<ObjetivoDietaPage> {
  final _formKey = GlobalKey<FormState>();
  final _objetivoDietaController = TextEditingController();

  @override
  void dispose() {
    _objetivoDietaController.dispose();
    super.dispose(); 
  }

   Future<void> _actualizarObjetivoDieta() async {
    if (_formKey.currentState!.validate()) {
      final objetivoDieta = _objetivoDietaController.text.toUpperCase();
      if (objetivoDieta == null) {
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
            .update({'objetivoDieta': objetivoDieta})
            .eq('id_usuario', userId)
            .select();

          if (response.isNotEmpty) {
         await generarPlanDieta();
          print("plan generado");
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
        title: Text('Objetivo dieta', style: TextStyle(color: ThemeAPP.of(context).secondaryText)),
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
                  controller: _objetivoDietaController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                  decoration: InputDecoration(
                    labelText: 'Objetivo dieta', 
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
                  onPressed: _actualizarObjetivoDieta,
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