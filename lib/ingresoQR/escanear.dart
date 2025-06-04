import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late MobileScannerController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController = MobileScannerController();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

 bool _escaneado = false;

void _onScan(String qrCodeData) {
  if (_escaneado) return; // Prevenir múltiples escaneos rápidos
  _escaneado = true;
  _cameraController.stop();

  List<String> partes = qrCodeData.split('|');
  if (partes.length >= 1) {
    String userId = partes[0];
    registrarAsistencia(context, userId).whenComplete(() {
      Future.delayed(Duration(seconds: 3), () {
        _escaneado = false;
        _cameraController.start(); // Reiniciar escaneo después de 3s
      });
    });
  } else {
    _mostrarMensaje(context, 'QR inválido.');
    _escaneado = false;
    _cameraController.start();
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escaneo de QR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: _cameraController,
              onDetect: (capture) {
                // Capturamos el código QR
                final String code = capture.barcodes.first.rawValue ?? '';
                if (code.isNotEmpty) {
                  // Llamamos a la función cuando detectamos un código QR
                  _onScan(code);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Escanea un código QR para registrar asistencia.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}


Future<void> registrarAsistencia(BuildContext context, String userId) async {
  final supabaseClient = Supabase.instance.client;

  try {
    // 1. Consultamos el estado de la membresía del usuario
    final response = await supabaseClient
      .from('membresia')
      .select('estado, fecha_inicio, fecha_fin')
      .eq('id_usuario', userId)
      .gte('fecha_fin', DateTime.now()) // Asegura que la fecha de fin es mayor o igual a hoy
      .lte('fecha_inicio', DateTime.now()) // Asegura que la fecha de inicio es menor o igual a hoy
      .single();

    // 2. Verificamos si el estado es 'Activo' (deberás conocer el UUID para 'Activo')
    if (response['estado'] != null) {
      String estadoId = response['estado'];
      if (estadoId == '047930a7-0dd1-4885-92da-7a849d353e9a') { // Reemplaza con el UUID del estado 'Activo'
        // 3. Si la membresía está activa, registramos la asistencia
        final now = DateTime.now();
        final insertResponse = await supabaseClient.from('asistencia').insert([
          {
            'id_usuario': userId,
            'fecha': now.toIso8601String(),
            'hora_ingreso': now.toIso8601String(),
          }
        ]);

        if (insertResponse.error == null) {
          print('Asistencia registrada exitosamente');
        } else {
          print('Error al registrar la asistencia: ${insertResponse.error?.message}');
        }
      } else {
        // Mostrar mensaje en AlertDialog
        _mostrarMensaje(context, 'La membresía no está activa.');
      }
    } else {
      // Mostrar mensaje en AlertDialog
      _mostrarMensaje(context, 'No se encontró la membresía o está vencida.');
    }
  } catch (error) {
    print('Error en la consulta o registro: $error');
    _mostrarMensaje(context, 'Ocurrió un error al consultar la membresía.');
  }
}

// Función para mostrar un AlertDialog con el mensaje
void _mostrarMensaje(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
