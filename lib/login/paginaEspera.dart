import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_movil/pagarMembresia/form_tarjeta_mercado_pago/form_tarjeta_mercado_pago_widget.dart';

class PaginaEspera extends StatelessWidget {
  const PaginaEspera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: const Color(0xFF1A1F23),
      body: SingleChildScrollView(
        child:
        Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                child:FormTarjetaMercadoPagoWidget(
                planName: 'Membresía Premium',
                planPrice: 100.0,
                userEmail: Supabase.instance.client.auth.currentUser?.email ??
                    'email@example.com',
                userId: Supabase.instance.client.auth.currentUser?.id ?? '',
              ),),
            ),
      ),
    );
  }
}