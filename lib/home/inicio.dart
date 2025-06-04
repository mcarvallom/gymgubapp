import 'package:app_movil/backend/supabase_config.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/home/menu/menuItems.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Importa Supabase

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<Inicio> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _supabase = Supabase.instance.client; // Inicializa el cliente Supabase
  final supabase = Supabase.instance.client;
  String _getTodayWeekday() {
  final now = DateTime.now();
  switch (now.weekday) {
    case DateTime.monday:
      return 'Lunes';
    case DateTime.tuesday:
      return 'Martes';
    case DateTime.wednesday:
      return 'Miércoles';
    case DateTime.thursday:
      return 'Jueves';
    case DateTime.friday:
      return 'Viernes';
    case DateTime.saturday:
      return 'Sábado';
    case DateTime.sunday:
      return 'Domingo';
    default:
      return '';
  }
}
  Map<String, dynamic> usuario = {}; 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserInformation();
    });
  }

  Future<void> _checkUserInformation() async {
    final userId = _supabase.auth.currentUser?.id; // Obtiene el ID del usuario autenticado

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

      if (usuario['peso'] == null) {
        Navigator.pushReplacementNamed(context, '/peso');
        return;
      }

      if (usuario['estatura'] == null) {
        Navigator.pushReplacementNamed(context, '/estatura');
        return;
      }
      if (usuario['objetivoDieta'] == null) {
        Navigator.pushReplacementNamed(context, '/objetivoDieta');
        return;
      }
      if (usuario['objetivoEjercicio'] == null) {
        Navigator.pushReplacementNamed(context, '/objetivoEjercicio');
        return;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children:[
          Container(
            decoration: BoxDecoration(
            color: Color(0xFF1A1F23),
          ),
          child: 
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logo/logoTransparenteGymHubBlanco.png',
                        width: 50.0, height: 50.0),
                    Container(
                        decoration: 
                        BoxDecoration(
                          color: Color.fromARGB(255, 135, 136, 137),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: 
                        IconButton(
                          icon:  Icon(
                                  Icons.person,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                  onPressed: () {
                                    // ignore: avoid_print
                                    print('IconButton pressed ...');
                                  },
                        ),
                      )
                    
                  ]
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hola',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      usuario['nombre'] ?? '',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ejercicios de hoy',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/ejerciciosPage'); // Navegar a otra ruta
                      },
                      child: Text(
                        'Mirar todo',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 255, 166),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              ]
              ),
                SizedBox(height: 20.0),
                FutureBuilder<List<Map<String, dynamic>>>(
                    future: _fetchEjercicios(), // Debes definir este método igual que en ejerciciosPage.dart
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                     if (snapshot.hasError ||
                            snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Sin ejercicios el día de hoy, debes recuperar energías...',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      final ejercicio = snapshot.data!.first;
                      final selectedDay = _getTodayWeekday(); // Si necesitas filtrar por día
                      return ContainerA(
                        ejercicio: ejercicio,
                        userId: SupabaseConfig.client.auth.currentUser!.id,
                        selectedDay: selectedDay,
                      );
                    },
                  ),
                
                
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mi dieta diaria',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/dietaPage'); // Navegar a otra ruta
                      },
                      child: Text(
                        'Mirar todo',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 255, 166),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              ]
              ),
                SizedBox(height: 20.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        
                        height: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1506084868230-bb9d95c24759?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8YnJlYWtmYXN0fGVufDB8fHx8MTcyOTQxNzI4M3ww&ixlib=rb-4.0.3&q=80&w=400'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Desayuno',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                                                    Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                              child: Container(
                                                width: 4.0,
                                                height: 16.0,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 255, 2, 80),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '3 Opciones',
                                              style: TextStyle(
                                                    
                                                    color: Color.fromARGB(255, 0, 255, 166),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                ),
                                      SizedBox(width: 10.0),
                                      Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 255, 2, 80),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Comenzar',
                                                    style: TextStyle(                
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                            ),
                            ],
                          ),
                        )
                  
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1524391931851-7bdd18f138c3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxsdW5jaHxlbnwwfHx8fDE3Mjk0MTczNjB8MA&ixlib=rb-4.0.3&q=80&w=400'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Almuerzo',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                  
                               Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                              child: Container(
                                                width: 4.0,
                                                height: 16.0,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 255, 2, 80),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '3 Opciones',
                                              style: TextStyle(
                                                    
                                                    color: Color.fromARGB(255, 0, 255, 166),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                ),
                                      SizedBox(width: 10.0),
                                      Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 255, 2, 80),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Comenzar',
                                                    style: TextStyle(                
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                            ),
                            ],
                          ),
                        )
                  
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        
                        height: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1605926637512-c8b131444a4b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxEaW5uZXJ8ZW58MHx8fHwxNzI5NDI1NjYxfDA&ixlib=rb-4.0.3&q=80&w=400'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Cena',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                                                    Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                              child: Container(
                                                width: 4.0,
                                                height: 16.0,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 255, 2, 80),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '3 Opciones',
                                              style: TextStyle(
                                                    
                                                    color: Color.fromARGB(255, 0, 255, 166),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                ),
                                      SizedBox(width: 10.0),
                                      Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 255, 2, 80),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Comenzar',
                                                    style: TextStyle(                
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                            ),
                            ],
                          ),
                        )
                  
                      ),
                    ],
                  ),
                )
            ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: menuItems(), // Menú en la parte inferior
        ),
      ]),
    );
  }

Future<List<Map<String, dynamic>>> _fetchEjercicios() async {
  final userId = supabase.auth.currentUser?.id;
  final today = _getTodayWeekday();
  final response = await supabase
      .from('ejercicios')
      .select('*')
      .eq('usuario_id', userId!)
      .eq('dia_semana', today);
  return response as List<Map<String, dynamic>>;
}}

class ContainerA extends StatelessWidget {
  final Map<String, dynamic> ejercicio;
  final String userId;
  final String? selectedDay;
  const ContainerA({required this.ejercicio, required this.userId, this.selectedDay});

  Future<bool> _hasValidRutinas() async {
    final supabase = Supabase.instance.client;
    final planes = await supabase
        .from('planes_ejercicio')
        .select('*')
        .eq('usuario_id', userId) as List<dynamic>;

    for (final plan in planes) {
      final rutinas = await supabase
          .from('rutinas_diarias')
          .select('*')
          .eq('plan_id', plan['plan_id'])
          .eq('dia_semana', selectedDay!) as List<dynamic>;
      for (final rutina in rutinas) {
        final ejerciciosRutina = await supabase
            .from('ejercicios_rutina')
            .select('*')
            .eq('rutina_id', rutina['rutina_id'].toString())
            .eq('ejercicio_id', ejercicio['ejercicio_id'].toString()) as List<dynamic>;
        for (final ej in ejerciciosRutina) {
          if (ej['series'] != null &&
              ej['repeticiones'] != null &&
              ej['repeticiones'].toString().isNotEmpty) {
            return true;
          }
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasValidRutinas(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }
        if (!snapshot.data!) {
          return SizedBox.shrink();
        }
        // Si hay al menos un ContainerD válido, muestra todo el contenido
        return Column(
          children:[ 
            SizedBox(height: 20,),
            Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image:DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1549476464-37392f717541?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8Z3ltJTIwY29hY2h8ZW58MHx8fHwxNzI5NDI1MTI2fDA&ixlib=rb-4.0.3&q=80&w=1080"),
                fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                                      color: const Color.fromARGB(100, 205, 205, 205),
                                    ),
            ),
            child: Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent,ThemeAPP.of(context).primaryText],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                                      color: const Color.fromARGB(100, 205, 205, 205),
                                    ),
            ),
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 100.0, 16.0, 16.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                          Text('Ejercicio: ${ejercicio['nombre'].toString()}',
                        style: TextStyle(color:ThemeAPP.of(context).secondaryText,fontWeight: FontWeight.bold, fontSize: 18)),
                  ]),SizedBox(height: 10),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchPlanesEjercicio(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                         return Center(child: Text('Sin ejercicios el día de hoy, debes recuperar energías...',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ));
                        }
                        return Column(
                          children: snapshot.data!.map((plan) =>
                            ContainerB(
                              plan: plan,
                              ejercicioId: ejercicio['ejercicio_id'].toString(),
                              selectedDay: selectedDay,
                            )
                          ).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
       ]
           );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchPlanesEjercicio() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('planes_ejercicio')
        .select('*')
        .eq('usuario_id', userId);
    return response as List<Map<String, dynamic>>;
  }
}

class ContainerB extends StatelessWidget {
  final Map<String, dynamic> plan;
  final String ejercicioId;
  final String? selectedDay;
  const ContainerB({required this.plan, required this.ejercicioId, this.selectedDay});

  Future<bool> _hasValidRutinas() async {
    final supabase = Supabase.instance.client;
    final rutinas = await supabase
        .from('rutinas_diarias')
        .select('*')
        .eq('plan_id', plan['plan_id'])
        .eq('dia_semana', selectedDay!) as List<dynamic>;

    for (final rutina in rutinas) {
      final ejerciciosRutina = await supabase
          .from('ejercicios_rutina')
          .select('*')
          .eq('rutina_id', rutina['rutina_id'].toString())
          .eq('ejercicio_id', ejercicioId) as List<dynamic>;
      for (final ej in ejerciciosRutina) {
        if (ej['series'] != null &&
            ej['repeticiones'] != null &&
            ej['repeticiones'].toString().isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasValidRutinas(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }
        if (!snapshot.data!) {
          return SizedBox.shrink();
        }
        // Si hay al menos un ejercicio válido, muestra el contenido
        return Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(6),
            
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Objetivo: ${plan['objetivo'].toString()}',
                  style: TextStyle(color:ThemeAPP.of(context).secondaryText,fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchRutinasDiarias(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return Column(
                    children: snapshot.data!.map((rutina) =>
                      ContainerC(rutina: rutina, ejercicioId: ejercicioId)
                    ).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchRutinasDiarias() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
      .from('rutinas_diarias')
      .select('*')
      .eq('plan_id', plan['plan_id'])
      .eq('dia_semana', selectedDay!);

    return response as List<Map<String, dynamic>>;
  }
}

class ContainerC extends StatelessWidget {
  final Map<String, dynamic> rutina;
  final String ejercicioId;

  const ContainerC({required this.rutina, required this.ejercicioId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rutina['enfoque'] != null && rutina['enfoque'].toString().isNotEmpty)
            Text('Enfoque: ${rutina['enfoque']}',style: TextStyle(color:ThemeAPP.of(context).secondaryText),),
          
          SizedBox(height: 4),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchEjerciciosRutina(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return SizedBox.shrink();
              }

              // Filtrar solo aquellos que tengan series y repeticiones
              final validEjercicios = snapshot.data!.where((ejRutina) {
                return ejRutina['series'] != null &&
                       ejRutina['repeticiones'] != null &&
                       ejRutina['repeticiones'].toString().isNotEmpty;
              }).toList();

              if (validEjercicios.isEmpty) {
                return SizedBox.shrink();
              }
              
              return Column(
                children: validEjercicios
                    .map((ejRutina) =>
                        ContainerD(ejercicioRutina: ejRutina))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchEjerciciosRutina() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
      .from('ejercicios_rutina')
      .select('*')
      .eq('rutina_id', rutina['rutina_id'].toString())
      .eq('ejercicio_id', ejercicioId);
    return response as List<Map<String, dynamic>>;
  }
}

class ContainerD extends StatelessWidget {
  final Map<String, dynamic> ejercicioRutina;

  const ContainerD({required this.ejercicioRutina});

  @override
  Widget build(BuildContext context) {
    // Solo se muestra si existen series y repeticiones
    if (ejercicioRutina['series'] == null ||
        ejercicioRutina['repeticiones'] == null ||
        ejercicioRutina['repeticiones'].toString().isEmpty) {
      return SizedBox.shrink();
    }
    
    return Container(
      decoration: BoxDecoration(
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
            child: Container(
              width: 4.0,
              height: 16.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 2, 80),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Text('Series: ${ejercicioRutina['series'].toString()}',style: TextStyle(color:Color.fromARGB(255, 0, 255, 166),fontSize: 16.0,
                                                              letterSpacing: 0.0,)),
          SizedBox(width: 10,),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
            child: Container(
              width: 4.0,
              height: 16.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 2, 80),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Text('Reps: ${ejercicioRutina['repeticiones'].toString()}',style: TextStyle(color:Color.fromARGB(255, 0, 255, 166),fontSize: 16.0,
                                                              letterSpacing: 0.0,)),
        ],
      ),
    );
  }
}