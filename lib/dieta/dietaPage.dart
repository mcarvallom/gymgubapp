import 'package:app_movil/backend/supabase_config.dart';
import 'package:app_movil/ejercicios/calendar.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DietaPage extends StatefulWidget {
  const DietaPage({super.key});

  @override
  State<DietaPage> createState() => _DietaPageState();
}

class _DietaPageState extends State<DietaPage> {
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
      List<Map<String, dynamic>> dietas, String? selectedDay) async {
    List<Map<String, dynamic>> validEjercicios = [];
    for (final dieta in dietas) {
      final containerA = ContainerA(
        dieta: dieta,
        userId: SupabaseConfig.client.auth.currentUser!.id,
        selectedDay: selectedDay,
      );
      final hasRutina = await containerA._hasValidRutinas();
      if (hasRutina) {
        validEjercicios.add(dieta);
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
    final response = await supabase.from('dieta').select('*');
    final dietas = response as List<Map<String, dynamic>>;
    _ejerciciosCache[fecha] = dietas;
    return dietas;
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
                            "https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85"),
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
                            'Mi dieta',
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
                              'Este plan de dieta es generado con Inteligencia Artificial',
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
                          'Mi dieta diaria',
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
                                'Sin dieta para el día de hoy...',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        final dietas = snapshot.data!;
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: _fetchValidEjercicios(dietas, selectedDay),
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
                                    'Sin dieta para el día de hoy...',
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
                                    (dieta) => ContainerA(
                                      dieta: dieta,
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
    final userId = SupabaseConfig.client.auth.currentUser?.id;
    final response =
        await supabase.from('dieta').select('*').eq('usuario_id', userId!);
    return response as List<Map<String, dynamic>>;
  }
}

class ContainerA extends StatelessWidget {
  final Map<String, dynamic> dieta;
  final String userId;
  final String? selectedDay;
  const ContainerA(
      {required this.dieta, required this.userId, this.selectedDay});

  String _getImageForTipo(String? tipo) {
    switch (tipo) {
      case "Desayuno":
        return "https://images.unsplash.com/photo-1506084868230-bb9d95c24759?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8YnJlYWtmYXN0fGVufDB8fHx8MTcyOTQxNzI4M3ww&ixlib=rb-4.0.3&q=80&w=400";
      case "Almuerzo":
        return "https://images.unsplash.com/photo-1524391931851-7bdd18f138c3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxsdW5jaHxlbnwwfHx8fDE3Mjk0MTczNjB8MA&ixlib=rb-4.0.3&q=80&w=400";
      case "Cena":
        return "https://images.unsplash.com/photo-1605926637512-c8b131444a4b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxEaW5uZXJ8ZW58MHx8fHwxNzI5NDI1NjYxfDA&ixlib=rb-4.0.3&q=80&w=400";
      default:
        return "https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85";
    }
  }

  Future<bool> _hasValidRutinas() async {
    final supabase = Supabase.instance.client;
    final planes = await supabase
        .from('dieta')
        .select('*')
        .eq('usuario_id', userId) as List<dynamic>;

    for (final plan in planes) {
      final dietasdiarias = await supabase
          .from('dieta_diaria')
          .select('*')
          .eq('dieta_id', plan['id'])
          .eq('dia_semana', selectedDay!) as List<dynamic>;
      for (final dietadiaria in dietasdiarias) {
        final ingredientes = await supabase
            .from('ingredientes_dieta')
            .select('*')
            .eq('dieta_diaria', dietadiaria['id'].toString()) as List<dynamic>;
        for (final ing in ingredientes) {
          if (ing['nombre_ingrediente'] != null &&
              ing['calorias'] != null &&
              ing['grasa'] != null &&
              ing['carbohidratos'] != null &&
              ing['azucar'] != null &&
              ing['proteina'] != null) {
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
                image: NetworkImage(_getImageForTipo(dieta['tipo'])),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text('Tipo: ${dieta['tipo']}',
                          style: TextStyle(
                              color: ThemeAPP.of(context).secondaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ]),
                    SizedBox(height: 10),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchPlanesDieta(),
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
                                    dietaID: dieta['id'].toString(),
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

  Future<List<Map<String, dynamic>>> _fetchPlanesDieta() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('dieta_diaria')
        .select('*')
        .eq('dieta_id', dieta['id'].toString())
        .eq('dia_semana', selectedDay!); // <-- Filtra por el día seleccionado
    return response as List<Map<String, dynamic>>;
  }
}

class ContainerB extends StatelessWidget {
  final Map<String, dynamic> plan;
  final String dietaID;
  final String? selectedDay;
  const ContainerB(
      {required this.plan, required this.dietaID, this.selectedDay});

  Future<bool> _hasValidRutinas() async {
    final supabase = Supabase.instance.client;
    final dietasdiarias = await supabase
        .from('dieta_diaria')
        .select('*')
        .eq('dieta_id', dietaID)
        .eq('dia_semana', selectedDay!) as List<dynamic>;

    for (final dietadiaria in dietasdiarias) {
      final ingredientes = await supabase
          .from('ingredientes_dieta')
          .select('*')
          .eq('dieta_diaria', dietadiaria['id'].toString()) as List<dynamic>;
      for (final ing in ingredientes) {
        if (ing['nombre_ingrediente'] != null &&
            ing['calorias'] != null &&
            ing['grasa'] != null &&
            ing['carbohidratos'] != null &&
            ing['azucar'] != null &&
            ing['proteina'] != null) {
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
              Text('Enfoque: ${plan['enfoque'].toString()}',
                  style: TextStyle(
                      color: ThemeAPP.of(context).secondaryText,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('${plan['titulo']}',
                    style: TextStyle(
                        color: ThemeAPP.of(context).secondaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ]),
            ],
          ),
        );
      },
    );
  }
}
