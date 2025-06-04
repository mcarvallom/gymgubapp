import 'package:flutter/material.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/backend/supabase_config.dart';

class nombreCompletoPage extends StatefulWidget {
  const nombreCompletoPage({super.key});

  @override
  _nombreCompletoPageState createState() => _nombreCompletoPageState();
}

class _nombreCompletoPageState extends State<nombreCompletoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    super.dispose();
  }

   Future<void> _actualizarnombreCompleto() async {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text;
      final apellido = _apellidoController.text;

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
            .update({'nombre': nombre, 'apellido': apellido})
            .eq('id_usuario', userId)
            .select();

        if (response.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Nombre y apellido actualizados exitosamente.')),
          );
          Navigator.pushReplacementNamed(context, '/rut');

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar el nombre y apellido')),
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
        title: Text('Ingresar Nombre y Apellido', style: TextStyle(color: ThemeAPP.of(context).secondaryText)),
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
                  controller: _nombreController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: ThemeAPP.of(context).primaryText),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
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
                      return 'Por favor, ingrese su nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _apellidoController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: ThemeAPP.of(context).primaryText),
                  decoration: InputDecoration(
                    labelText: 'Apellido',
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
                      return 'Por favor, ingrese su apellido';
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
                  onPressed: _actualizarnombreCompleto,
                  child: Text('Siguiente', style: TextStyle(color: ThemeAPP.of(context).primaryText)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}