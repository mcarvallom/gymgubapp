import 'package:app_movil/home/menu/menuItems.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _supabase = Supabase.instance.client;
  final supabase = Supabase.instance.client;

  Map<String, dynamic> usuario = {};
  @override
  @override
  void initState() {
    super.initState();
    _checkUserInformation(); // <-- Agrega esta línea
  }

  Future<void> _checkUserInformation() async {
    final userId =
        _supabase.auth.currentUser?.id; // Obtiene el ID del usuario autenticado

    if (userId == null) {
      print('Usuario no autenticado');
      return;
    }

    try {
      final response = await _supabase
          .from('usuario')
          .select()
          .eq('id_usuario', userId) // Filtra por el ID del usuario
          .single();

      setState(() {
        usuario = response; // Asignar el valor a la variable de clase
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1A1F23),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeAPP.of(context).secondaryText,
                          ),
                          child: ClipRRect(
                            child: Image.network(
                              usuario['imagenPerfil'] ??
                                  'https://xjrxihpqoqmecetwpaua.supabase.co/storage/v1/object/public/imagenes//logoTransparente%20GymHub.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            usuario['nombre'] ?? '',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            usuario['apellido'] ?? '',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        usuario['email'] ?? '',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Color(0xffcdcdcd), // Color del texto
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Color(0xffcdcdcd)), // Borde
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          print('');
                        },
                        child: Text('Editar perfil'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Mi cuenta',
                              style: TextStyle(
                                fontSize: 10,
                                color: ThemeAPP.of(context).secondaryText,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color(0xffcdcdcd),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {Navigator.pushNamed(context, '/asistencia');},
                                            child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 8, 0, 8),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.insert_chart_outlined,
                                                    color: ThemeAPP.of(context)
                                                        .secondaryText,
                                                    size: 24,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Mi asistencia',
                                                    style: TextStyle(
                                                      color: ThemeAPP.of(context)
                                                          .secondaryText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color:
                                                ThemeAPP.of(context).secondaryText,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: Color(0xffcdcdcd),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 8),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person_2_rounded,
                                                color: ThemeAPP.of(context)
                                                    .secondaryText,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Mis datos',
                                                style: TextStyle(
                                                  color: ThemeAPP.of(context)
                                                      .secondaryText,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color:
                                              ThemeAPP.of(context).secondaryText,
                                          size: 24,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Gimnasio',
                              style: TextStyle(
                                fontSize: 10,
                                color: ThemeAPP.of(context).secondaryText,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color(0xffcdcdcd),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.payment_rounded,
                                                color: ThemeAPP.of(context)
                                                    .secondaryText,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Mi suscripción',
                                                style: TextStyle(
                                                  color: ThemeAPP.of(context)
                                                      .secondaryText,
                                                ),
                                              )
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: ThemeAPP.of(context)
                                                .secondaryText,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      color: Color(0xffcdcdcd),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.auto_awesome,
                                                color: ThemeAPP.of(context)
                                                    .secondaryText,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'IA',
                                                style: TextStyle(
                                                  color: ThemeAPP.of(context)
                                                      .secondaryText,
                                                ),
                                              )
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: ThemeAPP.of(context)
                                                .secondaryText,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Preferencias',
                              style: TextStyle(
                                fontSize: 10,
                                color: ThemeAPP.of(context).secondaryText,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color(0xffcdcdcd),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/logout'); // Navegar a otra ruta
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.logout_outlined,
                                                  color: ThemeAPP.of(context)
                                                      .secondaryText,
                                                  size: 24,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Cerrar sesión',
                                                  style: TextStyle(
                                                    color: ThemeAPP.of(context)
                                                        .secondaryText,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: menuItems(), // Menú en la parte inferior
            ),
          ],
        ),
      ),
    );
  }
}
