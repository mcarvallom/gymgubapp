import 'package:flutter/material.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/backend/supabase_config.dart';

class EstaturaPage extends StatefulWidget {
  const EstaturaPage({super.key});

  @override
  _EstaturaPageState createState() => _EstaturaPageState();
}

class _EstaturaPageState extends State<EstaturaPage> {
  final _formKey = GlobalKey<FormState>();
  final _estaturaController = TextEditingController();

  @override
  void dispose() {
    _estaturaController.dispose();
    super.dispose();
  }

   Future<void> _actualizarEstatura() async {
    if (_formKey.currentState!.validate()) {
      final estatura = double.tryParse(_estaturaController.text);
      if (estatura == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, ingrese una estatura válida.')),
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
            .update({'estatura': estatura})
            .eq('id_usuario', userId)
            .select();
 
        if (response.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Estatura actualizada exitosamente.')),
          );
          if (response.isNotEmpty && response[0]['objetivoDieta'] == null) {
            Navigator.pushReplacementNamed(context, '/objetivoDieta');
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
        title: Text('Ingresar Estatura', style: TextStyle(color: ThemeAPP.of(context).secondaryText)),
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
                  controller: _estaturaController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                  decoration: InputDecoration(
                    labelText: 'Estatura (cm)',
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
                      return 'Por favor, ingrese su estatura';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, ingrese un número válido';
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
                  onPressed: _actualizarEstatura,
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