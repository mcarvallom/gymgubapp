import 'package:app_movil/app_localizacion.dart';
import 'package:app_movil/auth_guard.dart';
import 'package:app_movil/dieta/dietaPage.dart';
import 'package:app_movil/ejercicios/ejerciciosPage.dart';
import 'package:app_movil/home/inicio.dart';
import 'package:app_movil/ingresoQR/ingresoQR.dart';
import 'package:app_movil/login/login.dart';
import 'package:app_movil/login/logout.dart';
import 'package:app_movil/login/paginaEspera.dart';
import 'package:app_movil/login/primerospasos/EstaturaPage.dart';
import 'package:app_movil/login/primerospasos/direccion.dart';
import 'package:app_movil/login/primerospasos/numContacto.dart';
import 'package:app_movil/login/primerospasos/objetivoEjercicio.dart';
import 'package:app_movil/login/primerospasos/objetivodieta.dart';
import 'package:app_movil/login/primerospasos/rut.dart';
import 'package:app_movil/backend/supabase_config.dart';
import 'package:app_movil/perfil/asistencia.dart';
import 'package:app_movil/perfil/perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'login/primerospasos/PesoPage.dart';
// export PATH="$PATH:/Users/mcarvallom/flutter/bin"

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeDateFormatting('es'); // Inicializa la localización para español
  await SupabaseConfig.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1A1F23), // Color de fondo global
      ),
      debugShowCheckedModeBanner: false,
      title: 'GymHub',
      initialRoute: '/login',
      home: AuthGuard(child: PaginaEspera()),
      routes: {
        '/inicio': (context) => AuthGuard(child: Inicio()), 
        '/ingresoQR': (context) => AuthGuard(child: QRPage()), 
        '/ejerciciosPage': (context) => AuthGuard(child: EjerciciosPage()), 
        '/login': (context) => LoginPage(), 
        '/peso': (context) => AuthGuard(child: PesoPage()), 
        '/estatura': (context) => AuthGuard(child: EstaturaPage()), 
        '/rut': (context) => AuthGuard(child: RutPage()), 
        '/numContacto': (context) => AuthGuard(child: ContactoPage()), 
        '/direccion': (context) => AuthGuard(child: DireccionPage()), 
        '/logout': (context) => LogoutPage(), 
        '/PaginaEspera': (context) => PaginaEspera(),
        '/objetivoDieta': (context) => AuthGuard(child: ObjetivoDietaPage()), 
        '/objetivoEjercicio': (context) => AuthGuard(child: ObjetivoEjercicioPage()), 
        '/dietaPage':(context) => AuthGuard(child: DietaPage()), 
        '/perfil':(context) => AuthGuard(child: PerfilPage()),
        '/asistencia':(context) => AuthGuard(child: AsistenciaPage()), 
      },
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
      ],
      locale: const Locale('es'), 
    );
  }
}
