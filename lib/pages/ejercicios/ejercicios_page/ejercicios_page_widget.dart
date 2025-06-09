import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_calendar.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/botones_paginas_nav_bar/botones_paginas_nav_bar_widget.dart';
import '/pages/ejercicios/detalle_ejercicio_componente/detalle_ejercicio_componente_widget.dart';
import '/pages/home/sinejercicios/sinejercicios_widget.dart';
import '../../../gymhub/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ejercicios_page_model.dart';
export 'ejercicios_page_model.dart';

class EjerciciosPageWidget extends StatefulWidget {
  const EjerciciosPageWidget({super.key});

  static String routeName = 'ejerciciosPage';
  static String routePath = '/ejerciciosPage';

  @override
  State<EjerciciosPageWidget> createState() => _EjerciciosPageWidgetState();
}

class _EjerciciosPageWidgetState extends State<EjerciciosPageWidget> {
  late EjerciciosPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EjerciciosPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: GymHubTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                            'https://images.unsplash.com/photo-1518611012118-696072aa579a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxOHx8Z3ltfGVufDB8fHx8MTcyOTM0NjExNXww&ixlib=rb-4.0.3&q=80&w=1080',
                          ).image,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xB21B1B1E),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Mi plan semanal',
                              style: GymHubTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: GymHubTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: GymHubTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              'Mi plan',
                              style: GymHubTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: GymHubTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Este plan de ejercicios es generado con Inteligencia Artificial',
                                textAlign: TextAlign.center,
                                style: GymHubTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: GymHubTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: GymHubTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ]
                              .divide(SizedBox(height: 16.0))
                              .addToStart(SizedBox(height: 20.0))
                              .addToEnd(SizedBox(height: 20.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: wrapWithModel(
                        model: _model.botonesPaginasNavBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: BotonesPaginasNavBarWidget(),
                      ),
                    ),
                  ],
                ),
                GymHubCalendar(
                  color: GymHubTheme.of(context).primary,
                  iconColor: GymHubTheme.of(context).primaryText,
                  weekFormat: true,
                  weekStartsMonday: true,
                  initialDate: getCurrentTimestamp,
                  rowHeight: 48.0,
                  onChange: (DateTimeRange? newSelectedDate) {
                    safeSetState(
                        () => _model.calendarSelectedDay = newSelectedDate);
                  },
                  titleStyle: GymHubTheme.of(context).titleLarge.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              GymHubTheme.of(context).titleLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            GymHubTheme.of(context).titleLarge.fontStyle,
                      ),
                  dayOfWeekStyle: GymHubTheme.of(context)
                      .bodyLarge
                      .override(
                        font: GoogleFonts.inter(
                          fontWeight:
                              GymHubTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              GymHubTheme.of(context).bodyLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            GymHubTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            GymHubTheme.of(context).bodyLarge.fontStyle,
                      ),
                  dateStyle: GymHubTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: GymHubTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              GymHubTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            GymHubTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            GymHubTheme.of(context).bodyMedium.fontStyle,
                      ),
                  selectedDateStyle: GymHubTheme.of(context)
                      .titleSmall
                      .override(
                        font: GoogleFonts.interTight(
                          fontWeight: GymHubTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              GymHubTheme.of(context).titleSmall.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            GymHubTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            GymHubTheme.of(context).titleSmall.fontStyle,
                      ),
                  inactiveDateStyle: GymHubTheme.of(context)
                      .labelMedium
                      .override(
                        font: GoogleFonts.inter(
                          fontWeight: GymHubTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: GymHubTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            GymHubTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            GymHubTheme.of(context).labelMedium.fontStyle,
                      ),
                  locale: FFLocalizations.of(context).languageCode,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mi plan diario',
                              style: GymHubTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: GymHubTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              dateTimeFormat(
                                "MMMEd",
                                _model.calendarSelectedDay!.start,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              style: GymHubTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: GymHubTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: GymHubTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: GymHubTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: GymHubTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<List<PlanesEjercicioRow>>(
                        future: _model.planEjercicio(
                          uniqueQueryKey: currentUserUid,
                          requestFn: () =>
                              PlanesEjercicioTable().querySingleRow(
                            queryFn: (q) => q.eqOrNull(
                              'usuario_id',
                              currentUserUid,
                            ),
                          ),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SinejerciciosWidget(),
                            );
                          }
                          List<PlanesEjercicioRow>
                              planEjercicioQuerySinglePlanesEjercicioRowList =
                              snapshot.data!;

                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final planEjercicioQuerySinglePlanesEjercicioRow =
                              planEjercicioQuerySinglePlanesEjercicioRowList
                                      .isNotEmpty
                                  ? planEjercicioQuerySinglePlanesEjercicioRowList
                                      .first
                                  : null;

                          return Container(
                            decoration: BoxDecoration(),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: FutureBuilder<List<RutinasDiariasRow>>(
                                future: _model.rutinaDiaria(
                                  uniqueQueryKey: functions.obtenerdia(
                                      _model.calendarSelectedDay!.start),
                                  requestFn: () =>
                                      RutinasDiariasTable().queryRows(
                                    queryFn: (q) => q
                                        .eqOrNull(
                                          'plan_id',
                                          planEjercicioQuerySinglePlanesEjercicioRow
                                              ?.planId,
                                        )
                                        .eqOrNull(
                                          'dia_semana',
                                          functions.obtenerdia(
                                              _model.calendarSelectedDay!.end),
                                        ),
                                  ),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SinejerciciosWidget(),
                                    );
                                  }
                                  List<RutinasDiariasRow>
                                      columnRutinasDiariasRowList =
                                      snapshot.data!;

                                  if (columnRutinasDiariasRowList.isEmpty) {
                                    return Center(
                                      child: SinejerciciosWidget(),
                                    );
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(
                                        columnRutinasDiariasRowList.length,
                                        (columnIndex) {
                                      final columnRutinasDiariasRow =
                                          columnRutinasDiariasRowList[
                                              columnIndex];
                                      return FutureBuilder<
                                          List<EjerciciosRutinaRow>>(
                                        future: _model.ejercicioRutina(
                                          uniqueQueryKey:
                                              columnRutinasDiariasRow.rutinaId
                                                  .toString(),
                                          requestFn: () =>
                                              EjerciciosRutinaTable()
                                                  .querySingleRow(
                                            queryFn: (q) => q.eqOrNull(
                                              'rutina_id',
                                              columnRutinasDiariasRow.rutinaId,
                                            ),
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SinejerciciosWidget(),
                                            );
                                          }
                                          List<EjerciciosRutinaRow>
                                              containerEjerciciosRutinaRowList =
                                              snapshot.data!;

                                          // Return an empty Container when the item does not exist.
                                          if (snapshot.data!.isEmpty) {
                                            return Container();
                                          }
                                          final containerEjerciciosRutinaRow =
                                              containerEjerciciosRutinaRowList
                                                      .isNotEmpty
                                                  ? containerEjerciciosRutinaRowList
                                                      .first
                                                  : null;

                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .primaryBackground,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    'https://images.unsplash.com/photo-1549476464-37392f717541?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8Z3ltJTIwY29hY2h8ZW58MHx8fHwxNzI5NDI1MTI2fDA&ixlib=rb-4.0.3&q=80&w=1080',
                                                  ).image,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: GymHubTheme.of(
                                                          context)
                                                      .lineColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              DetalleEjercicioComponenteWidget(
                                                            ejericicio:
                                                                containerEjerciciosRutinaRow!
                                                                    .ejercicioId!,
                                                            planId:
                                                                columnRutinasDiariasRow
                                                                    .planId,
                                                            rutina:
                                                                columnRutinasDiariasRow
                                                                    .rutinaId,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      end: AlignmentDirectional(
                                                          0, 1.0),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16.0,
                                                                100.0,
                                                                16.0,
                                                                16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        FutureBuilder<
                                                            List<
                                                                EjerciciosRow>>(
                                                          future:
                                                              _model.ejercicio(
                                                            uniqueQueryKey:
                                                                containerEjerciciosRutinaRow
                                                                    ?.ejercicioId
                                                                    .toString(),
                                                            requestFn: () =>
                                                                EjerciciosTable()
                                                                    .querySingleRow(
                                                              queryFn: (q) =>
                                                                  q.eqOrNull(
                                                                'ejercicio_id',
                                                                containerEjerciciosRutinaRow
                                                                    ?.ejercicioId,
                                                              ),
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child:
                                                                    SinejerciciosWidget(),
                                                              );
                                                            }
                                                            List<EjerciciosRow>
                                                                textEjerciciosRowList =
                                                                snapshot.data!;

                                                            final textEjerciciosRow =
                                                                textEjerciciosRowList
                                                                        .isNotEmpty
                                                                    ? textEjerciciosRowList
                                                                        .first
                                                                    : null;

                                                            return Text(
                                                              'Ejercicio: ${textEjerciciosRow?.nombre}',
                                                              style: GymHubTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: GymHubTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: GymHubTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            );
                                                          },
                                                        ),
                                                        Text(
                                                          'Objetivo: ${planEjercicioQuerySinglePlanesEjercicioRow?.objetivo}',
                                                          style: GymHubTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: GymHubTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Text(
                                                          'Enfoque: ${columnRutinasDiariasRow.enfoque}',
                                                          style: GymHubTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: GymHubTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 4.0,
                                                                height: 16.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Series: ${containerEjerciciosRutinaRow?.series?.toString()}',
                                                              style: GymHubTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: GymHubTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: GymHubTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: GymHubTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 4.0,
                                                                height: 16.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Repeticiones: ${containerEjerciciosRutinaRow?.repeticiones}',
                                                              style: GymHubTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: GymHubTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: GymHubTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: GymHubTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).divide(SizedBox(height: 16.0)),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ].addToEnd(SizedBox(height: 30.0)),
            ),
          ),
        ),
      ),
    );
  }
}
