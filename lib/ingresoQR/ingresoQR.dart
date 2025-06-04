import 'dart:async';

import 'package:app_movil/home/menu/menuItems.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import '../backend/supabase_config.dart';

class QRPage extends StatefulWidget {
  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  String qrData = '';
  int secondsRemaining = 60;
  Timer? _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _generateQR();
    _startTimer();
  }

  Future<void> _generateQR() async {
    try {
      final userId = SupabaseConfig.client.auth.currentUser?.id;
      if (userId == null) {
        print('Usuario no autenticado');
        return;
      }

      final response = await SupabaseConfig.client
          .from('usuario')
          .select('nombre, apellido')
          .eq('id_usuario', userId) // Asegúrate de que este campo sea correcto en tu tabla
          .single();

      if (response['nombre'] != null && response['apellido'] != null) {
        final nombre = response['nombre'] as String;
        final apellido = response['apellido'] as String;
        final now = DateTime.now();
        final formattedDate = DateFormat('yyyyMMdd_HHmm').format(now);

        setState(() {
          qrData = '$userId|$nombre|$apellido|$formattedDate';
        });
      }
 else {
        print('No se encontraron datos del usuario autenticado.');
      }
    } catch (error) {
      print('Error al obtener datos del usuario: $error');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        secondsRemaining--;
        if (secondsRemaining <= 0) {
          secondsRemaining = 60;
          _generateQR();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [Container(
          decoration: BoxDecoration(
              color: Color(0xFF1A1F23),
            ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  qrData.isNotEmpty
                    ? QrImageView(
                        data: qrData,
                        size: 200.0,
                        foregroundColor: ThemeAPP.of(context).secondaryText,
                      )
                    : Text('No se pudo generar el código QR'),
          
                  SizedBox(height: 20),
                  Text(
                    'Actualizando en: $secondsRemaining segundos',
                    style: TextStyle(fontSize: 16, color: ThemeAPP.of(context).secondaryText,),
                    
                  ),
                ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: menuItems(), // Menú en la parte inferior
        ),]
      ),
    );
  }
}
