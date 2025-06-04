import 'package:app_movil/backend/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_movil/login/paginaEspera.dart';
import 'package:app_movil/login/login.dart';

class AuthGuard extends StatefulWidget {
  final Widget child;

  const AuthGuard({Key? key, required this.child}) : super(key: key);

  @override
  _AuthGuardState createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  final _supabase = Supabase.instance.client;
  late final Stream<AuthState> _authStateChanges;
  final userId = SupabaseConfig.client.auth.currentUser?.id;
  bool _membresiaVerificada = false;
  String? _estadoMembresia;

  @override
  void initState() {
    super.initState();
    _authStateChanges = _supabase.auth.onAuthStateChange;
    _verificarMembresia();
  }

  Future<void> _verificarMembresia() async {
    try {
      final session = _supabase.auth.currentSession;

      if (session == null) {
        setState(() => _membresiaVerificada = true);
        return;
      }

      final response = await _supabase
          .from('membresia')
          .select('estado')
          .eq('id_usuario', userId!)
          .maybeSingle();

      setState(() {
        _estadoMembresia = response?['estado'] as String?;
        _membresiaVerificada = true;
      });
    } catch (e) {
      print('Error verificando membresía: $e');
      setState(() => _membresiaVerificada = true);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: _authStateChanges,
      builder: (context, snapshot) {
        // Si no hay sesión, redirige a login
        if (_supabase.auth.currentUser == null) {
          return LoginPage();
        }

        // Si aún no se verifica la membresía, muestra spinner
        if (!_membresiaVerificada) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Solo aquí decide si muestra el contenido o el formulario de pago
      if (_estadoMembresia == '047930a7-0dd1-4885-92da-7a849d353e9a') {
        return widget.child; // Permite acceso al contenido protegido
      } else {
        // Redirige a página de pago si no tiene membresía activa
        Future.microtask(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PaginaEspera()),
          );
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
    },
  );
}}
