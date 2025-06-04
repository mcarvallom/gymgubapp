import 'package:app_movil/home/menu/menuItems.dart';
import 'package:app_movil/utiles/theme.dart';
import 'package:app_movil/ejercicios/calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AsistenciaPage extends StatefulWidget {
  const AsistenciaPage({super.key});

  @override
  State<AsistenciaPage> createState() => _AsistenciaPageState();
}

class _AsistenciaPageState extends State<AsistenciaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _supabase = Supabase.instance.client;
  final supabase = Supabase.instance.client;
  Map<String, dynamic> usuario = {};
  Map<String, dynamic>? asistencia;
  String? direccion;

  DateTimeRange? calendarSelectedDay;

  @override
  void initState() {
    super.initState();
    _checkUserInformation(); // <-- Agrega esta línea
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );
    _loadData(calendarSelectedDay!.start);
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

  Future<void> _loadData(DateTime fechaSeleccionada) async {
  final userId = _supabase.auth.currentUser?.id;
  if (userId == null) return;

  try {
    // Obtener usuario
    final userResponse = await _supabase
        .from('usuario')
        .select()
        .eq('id_usuario', userId)
        .single();

    final inicio = DateTime(
      fechaSeleccionada.year,
      fechaSeleccionada.month,
      fechaSeleccionada.day,
    );
    final fin = inicio.add(Duration(days: 1));

    // Obtener asistencia SOLO para el día seleccionado
    final asistenciaResponse = await _supabase
        .from('asistencia')
        .select()
        .eq('id_usuario', userId)
        .gte('hora_ingreso', inicio.toIso8601String())
        .lt('hora_ingreso', fin.toIso8601String())
        .order('hora_ingreso', ascending: false)
        .limit(1)
        .maybeSingle();

    // Obtener dirección
    final contactoResponse = await _supabase
        .from('contacto')
        .select('direccion')
        .maybeSingle();

    setState(() {
      usuario = userResponse;
      asistencia = asistenciaResponse;
      direccion = contactoResponse?['direccion'];
    });
  } catch (e) {
    print('Error: $e');
  }
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
        body: Container(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
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
                            SizedBox(width: 10,),
                      Text(
                        // Día del mes
                        calendarSelectedDay != null
                            ? calendarSelectedDay!.start.day.toString()
                            : '',
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: ThemeAPP.of(context).secondaryText,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // Día de la semana
                            calendarSelectedDay != null
                                ? _getSelectedWeekday() ?? ''
                                : '',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeAPP.of(context).secondaryText,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            // Mes en español
                            calendarSelectedDay != null
                                ? _getMonthName(
                                    calendarSelectedDay!.start.month)
                                : '',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeAPP.of(context).secondaryText,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                    if (newSelectedDate != null) {
                      _loadData(newSelectedDate.start);
                    }
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF656565),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        if (asistencia == null || asistencia?['hora_ingreso'] == null)
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "No tiene asistencia este día",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      else
                        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: ThemeAPP.of(context).secondaryText,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  decoration: BoxDecoration(
                    color: ThemeAPP.of(context).lineColor,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        10.0, 10.0, 10.0, 10.0),
                    child: Text(
                      'Ingreso',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Fecha: '),
                          Text(
                            asistencia?['hora_ingreso'] != null
                                ? DateTime.parse(asistencia![
                                        'hora_ingreso'])
                                    .toLocal()
                                    .toString()
                                    .substring(0, 10)
                                : 'Sin registro',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Hora ingreso: '),
                          Text(
                            asistencia?['hora_ingreso'] != null
                                ? DateTime.parse(asistencia![
                                        'hora_ingreso'])
                                    .toLocal()
                                    .toString()
                                    .substring(11, 16)
                                : 'Sin registro',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Dirección: '),
                          Text(direccion ?? 'Sin dirección'),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

                      ],
                    ),
                  ),
                )
              ],
            ))));
  }
}

String _getMonthName(int month) {
  const meses = [
    '', // Para que enero sea el índice 1
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];
  return meses[month];
}
