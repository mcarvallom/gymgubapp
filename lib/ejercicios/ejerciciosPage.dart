import 'package:app_movil/backend/supabase_config.dart';
import 'package:app_movil/ejercicios/calendar.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EjerciciosPage extends StatefulWidget {
  const EjerciciosPage({super.key});

  @override
  State<EjerciciosPage> createState() => _EjerciciosPageState();
}

class _EjerciciosPageState extends State<EjerciciosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final userId = SupabaseConfig.client.auth.currentUser?.id;
  final supabase = Supabase.instance.client;

  // Cache por fecha
  final Map<String, List<Map<String, dynamic>>> _ejerciciosCache = {};

  DateTimeRange? calendarSelectedDay;

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchValidEjercicios(
      List<Map<String, dynamic>> ejercicios, String? selectedDay) async {
    List<Map<String, dynamic>> validEjercicios = [];
    for (final ejercicio in ejercicios) {
      final containerA = ContainerA(
        ejercicio: ejercicio,
        userId: SupabaseConfig.client.auth.currentUser!.id,
        selectedDay: selectedDay,
      );
      final hasRutina = await containerA._hasValidRutinas();
      if (hasRutina) {
        validEjercicios.add(ejercicio);
      }
    }
    return validEjercicios;
  }

  String? _getSelectedWeekday() {
    if (calendarSelectedDay != null) {
      final date = calendarSelectedDay!.start;
      switch (date.weekday) {
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
          return null;
      }
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> _fetchEjerciciosPorFecha(
      String fecha) async {
    if (_ejerciciosCache.containsKey(fecha)) {
      return _ejerciciosCache[fecha]!;
    }
    final response = await supabase.from('ejercicios').select('*');
    final ejercicios = response as List<Map<String, dynamic>>;
    _ejerciciosCache[fecha] = ejercicios;
    return ejercicios;
  }

  @override
  Widget build(BuildContext context) {
    final selectedDay = _getSelectedWeekday();
    final fechaKey = calendarSelectedDay != null
        ? DateFormat('yyyy-MM-dd').format(calendarSelectedDay!.start)
        : DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A1F23),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1518611012118-696072aa579a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxOHx8Z3ltfGVufDB8fHx8MTcyOTM0NjExNXww&ixlib=rb-4.0.3&q=80&w=1080"),
                        fit: BoxFit.cover,
                      ),
                      color: ThemeAPP.of(context).secondaryBackground,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xb21b1b1e),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mi plan semanal',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: ThemeAPP.of(context).secondaryText,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Mi plan',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: ThemeAPP.of(context).secondaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Este plan de ejercicios es generado con Inteligencia Artificial',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: ThemeAPP.of(context).secondaryText,
                                
                              ),textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 135, 136, 137),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 135, 136, 137),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.person,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GymHubCalendar(
                color: ThemeAPP.of(context).primary,
                iconColor: ThemeAPP.of(context).secondaryText,
                weekFormat: true,
                weekStartsMonday: true,
                initialDate: DateTime.now(),
                rowHeight: 60.0,
                locale: 'es',
                onChange: (DateTimeRange? newSelectedDate) {
                  setState(() {
                    calendarSelectedDay = newSelectedDate;
                  });
                },
                titleStyle: ThemeAPP.of(context).titleLarge.override(
                      font: GoogleFonts.interTight(),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                dayOfWeekStyle: ThemeAPP.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(),
                      color: Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                dateStyle: ThemeAPP.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                selectedDateStyle: ThemeAPP.of(context).titleSmall.override(
                      font: GoogleFonts.interTight(),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                inactiveDateStyle: ThemeAPP.of(context).labelMedium.override(
                      font: GoogleFonts.inter(),
                      color: Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mi plan diario',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          calendarSelectedDay != null
                              ? DateFormat('MMMEd', 'es')
                                  .format(calendarSelectedDay!.start)
                              : 'Selecciona un día',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 0, 255, 166),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchEjerciciosPorFecha(fechaKey),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        final ejercicios = snapshot.data!;
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future:
                              _fetchValidEjercicios(ejercicios, selectedDay),
                          builder: (context, validSnapshot) {
                            if (validSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (validSnapshot.hasError ||
                                validSnapshot.data == null ||
                                validSnapshot.data!.isEmpty) {
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
                            return Column(
                              children: validSnapshot.data!
                                  .map(
                                    (ejercicio) =>
                                        // Aquí comienza ContainerA
                                        ContainerA(
                                      ejercicio: ejercicio,
                                      userId: SupabaseConfig
                                          .client.auth.currentUser!.id,
                                      selectedDay: selectedDay,
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchEjercicios() async {
    final response = await supabase.from('ejercicios').select('*').eq('usuario_id', userId!);;
    return response as List<Map<String, dynamic>>;
  }
}

class ContainerA extends StatelessWidget {
  final Map<String, dynamic> ejercicio;
  final String userId;
  final String? selectedDay;
  const ContainerA(
      {required this.ejercicio, required this.userId, this.selectedDay});

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
                .eq('ejercicio_id', ejercicio['ejercicio_id'].toString())
            as List<dynamic>;
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
        return Column(children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1549476464-37392f717541?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8Z3ltJTIwY29hY2h8ZW58MHx8fHwxNzI5NDI1MTI2fDA&ixlib=rb-4.0.3&q=80&w=1080"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(100, 205, 205, 205),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    ThemeAPP.of(context).primaryText
                  ],
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
                padding:
                    EdgeInsetsDirectional.fromSTEB(16.0, 100.0, 16.0, 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(mainAxisSize: MainAxisSize.max, children: [
                      Text('Ejercicio: ${ejercicio['nombre'].toString()}',
                          style: TextStyle(
                              color: ThemeAPP.of(context).secondaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ]),
                    SizedBox(height: 10),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchPlanesEjercicio(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return SizedBox.shrink();
                        }
                        return Column(
                          children: snapshot.data!
                              .map((plan) => ContainerB(
                                    plan: plan,
                                    ejercicioId:
                                        ejercicio['ejercicio_id'].toString(),
                                    selectedDay: selectedDay,
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
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
  const ContainerB(
      {required this.plan, required this.ejercicioId, this.selectedDay});

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
                  style: TextStyle(
                      color: ThemeAPP.of(context).secondaryText,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchRutinasDiarias(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return Column(
                    children: snapshot.data!
                        .map((rutina) => ContainerC(
                            rutina: rutina, ejercicioId: ejercicioId))
                        .toList(),
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
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rutina['enfoque'] != null &&
              rutina['enfoque'].toString().isNotEmpty)
            Text(
              'Enfoque: ${rutina['enfoque']}',
              style: TextStyle(color: ThemeAPP.of(context).secondaryText),
            ),
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
                    .map((ejRutina) => ContainerD(ejercicioRutina: ejRutina))
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
      decoration: BoxDecoration(),
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
          SizedBox(
            width: 10,
          ),
          Text('Series: ${ejercicioRutina['series'].toString()}',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 255, 166),
                fontSize: 16.0,
                letterSpacing: 0.0,
              )),
          SizedBox(
            width: 10,
          ),
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
          SizedBox(
            width: 10,
          ),
          Text('Reps: ${ejercicioRutina['repeticiones'].toString()}',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 255, 166),
                fontSize: 16.0,
                letterSpacing: 0.0,
              )),
        ],
      ),
    );
  }
}
