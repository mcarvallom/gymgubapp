import 'package:app_movil/backend/supabase_config.dart';
import 'package:app_movil/login/paginaEspera.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();

  // Controladores para los campos de Login
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _supabase = Supabase.instance.client;
  late final Stream<AuthState> _authStateChanges;
  final _passwordController = TextEditingController();
  final userId = SupabaseConfig.client.auth.currentUser?.id;
  bool _membresiaVerificada = false;
  bool _obscurePassword = true; // <-- Variable para mostrar/ocultar
  String? _estadoMembresia;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _redirectIfLoggedIn();
  }

  Future<void> _redirectIfLoggedIn() async {
    final session = SupabaseConfig.client.auth.currentSession;
    if (session != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/inicio',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _authStateChanges = _supabase.auth.onAuthStateChange;

    super.dispose();
  }

  Future<void> _verificarMembresia(String userId) async {
    try {
      final response = await _supabase
          .from('membresia')
          .select('estado')
          .eq('id_usuario', userId)
          .maybeSingle();

      _estadoMembresia = response?['estado'] as String?;
      return;
    } catch (e) {
      print('Error verificando membresía: $e');
      _estadoMembresia = null;
      return;
    }
  }

  Future<void> _signIn() async {
    if (_loginFormKey.currentState!.validate()) {
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
        final response = await SupabaseConfig.client.auth.signInWithPassword(
          email: _loginEmailController.text,
          password: _loginPasswordController.text,
        );
        if (response.user != null) {
          final userId = response.user!.id;
          await _verificarMembresia(userId);

          Navigator.of(context).pop(); // Cierra el loader

          if (_estadoMembresia == '047930a7-0dd1-4885-92da-7a849d353e9a') {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/inicio',
                (Route<dynamic> route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Inicio de sesión exitoso')),
              );
            }
          } else {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PaginaEspera()),
              );
            }
          }
        } else {
          Navigator.of(context).pop(); // Cierra el loader si no hay usuario
        }
      } catch (error) {
        Navigator.of(context).pop(); // Cierra el loader en error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al iniciar sesión: $error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1F23),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            height: 600,
            decoration: BoxDecoration(
              color: Color(0xFF1A1F23),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: const Color.fromARGB(100, 205, 205, 205),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/logoTransparenteGymHubBlanco.png',
                  width: 200,
                  height: 200,
                ),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Entrar'),
                  ],
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                ),
                SizedBox(
                  height:
                      300, // Asegura un mínimo del 80% de la altura de la pantalla

                  child: Form(
                    key: _loginFormKey,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _loginEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                color: ThemeAPP.of(context).secondaryText),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: ThemeAPP.of(context).secondaryText),
                              filled: true,
                              fillColor:
                                  ThemeAPP.of(context).secondaryBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un correo electrónico';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _loginPasswordController,
                            style: TextStyle(
                                color: ThemeAPP.of(context).secondaryText),
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(
                                  color: ThemeAPP.of(context).secondaryText),
                              filled: true,
                              fillColor:
                                  ThemeAPP.of(context).secondaryBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: ThemeAPP.of(context).secondaryText,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese una contraseña';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeAPP.of(context).primary,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              textStyle: TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            onPressed: _signIn,
                            child: Text('Entrar',
                                style: TextStyle(
                                    color: ThemeAPP.of(context).primaryText)),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "¿Olvidaste tu contraseña?",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "> Haz clic aquí <",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
