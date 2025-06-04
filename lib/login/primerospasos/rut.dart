import 'package:flutter/material.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/backend/supabase_config.dart';

class RutPage extends StatefulWidget {
  const RutPage({Key? key});

  @override
  _RutPageState createState() => _RutPageState();
}

class _RutPageState extends State<RutPage> {
  final _formKey = GlobalKey<FormState>();
  final _rutController = TextEditingController();
  final _dvController = TextEditingController();

  @override
  void dispose() {
    _rutController.dispose();
    _dvController.dispose();
    super.dispose();
  }

  // Función para validar el dígito verificador (DV)
  bool _validarDV(String rut, String dv) {
    int rutNumerico = int.parse(rut);
    int suma = 0;
    int multiplicador = 2;

    while (rutNumerico > 0) {
      suma += (rutNumerico % 10) * multiplicador;
      rutNumerico ~/= 10;
      multiplicador++;
      if (multiplicador > 7) {
        multiplicador = 2;
      }
    }

    int resultado = 11 - (suma % 11);
    String dvEsperado = (resultado == 11) ? '0' : (resultado == 10) ? 'K' : resultado.toString();

    return dvEsperado.toUpperCase() == dv.toUpperCase();
  }


  Future<void> _actualizarRut() async {
    if (_formKey.currentState!.validate()) {
      final rut = _rutController.text;
      final dv = _dvController.text.toUpperCase();

      if (!_validarDV(rut, dv)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El RUT ingresado no es válido.')),
        );
        return;
      }

      final rutNumerico = int.tryParse(rut);

      if (rutNumerico == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, ingrese un RUT válido (solo números).')),
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
            .update({'rut': rutNumerico, 'dv': dv})
            .eq('id_usuario', userId)
            .select();

        if (response.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('RUT actualizado exitosamente.')),
          );
          Navigator.pushReplacementNamed(context, '/numContacto');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar el RUT.')),
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
        title: Text('Ingresar RUT', style: TextStyle(color: ThemeAPP.of(context).secondaryText)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _rutController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: ThemeAPP.of(context).primaryText),
                        decoration: InputDecoration(
                          labelText: 'RUT',
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
                            return 'Por favor, ingrese su RUT';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Por favor, ingrese un número válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      child: TextFormField(
                        controller: _dvController,
                        keyboardType: TextInputType.text,
                        maxLength: 1,
                        style: TextStyle(color: ThemeAPP.of(context).primaryText),
                        decoration: InputDecoration(
                          labelText: 'DV',
                          labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                          filled: true,
                          fillColor: ThemeAPP.of(context).secondaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                          counterText: '', // Hide the maxLength counter
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su DV';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
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
                  onPressed: _actualizarRut,
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