import 'package:flutter/material.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/backend/supabase_config.dart';

class DireccionPage extends StatefulWidget {
  const DireccionPage({super.key});

  @override
  _DireccionPageState createState() => _DireccionPageState();
}

class _DireccionPageState extends State<DireccionPage> {
  final _formKey = GlobalKey<FormState>();
  final _direccionController = TextEditingController();

  @override
  void dispose() {
    _direccionController.dispose();
    super.dispose();
  }

   Future<void> _actualizarDireccion() async {
    if (_formKey.currentState!.validate()) {
      final direccion = _direccionController.text;

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
            .update({'direccion': direccion})
            .eq('id_usuario', userId)
            .select();

        if (response.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Dirección actualizada exitosamente.')),
          );
          Navigator.pushReplacementNamed(context, '/peso');

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar la dirección')),
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
        iconTheme: IconThemeData(color: ThemeAPP.of(context).secondaryText),
        title: Text('Ingresar Dirección', style: TextStyle(color: ThemeAPP.of(context).secondaryText)),
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
                  controller: _direccionController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: ThemeAPP.of(context).primaryText),
                  decoration: InputDecoration(
                    labelText: 'Dirección',
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
                      return 'Por favor, ingrese su dirección';
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
                  onPressed: _actualizarDireccion,
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