import 'package:flutter/material.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/backend/supabase_config.dart';

class PesoPage extends StatefulWidget {
  const PesoPage({super.key});

  @override
  _PesoPageState createState() => _PesoPageState();
}

class _PesoPageState extends State<PesoPage> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();

  @override
  void dispose() {
    _pesoController.dispose();
    super.dispose(); 
  }

   Future<void> _actualizarPeso() async {
    if (_formKey.currentState!.validate()) {
      final peso = int.tryParse(_pesoController.text);
      if (peso == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, ingrese un peso válido.')),
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
            .update({'peso': peso})
            .eq('id_usuario', userId)
            .select();

          if (response.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Peso actualizado exitosamente.')),
          );
          // Verifica si la lista response no está vacía y si el primer elemento contiene 'estatura' nula
          if (response.isNotEmpty && response[0]['estatura'] == null) {
            Navigator.pushReplacementNamed(context, '/estatura');
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
        title: Text('Ingresar Peso', style: TextStyle(color: ThemeAPP.of(context).secondaryText)),
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
                  controller: _pesoController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)', 
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
                      return 'Por favor, ingrese su peso';
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
                  onPressed: _actualizarPeso,
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