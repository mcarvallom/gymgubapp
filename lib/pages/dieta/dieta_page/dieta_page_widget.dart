import 'package:gymhub_app/backend/supabase/database/tables/comidas.dart';
import 'package:provider/provider.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_calendar.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/botones_paginas_nav_bar/botones_paginas_nav_bar_widget.dart';
import '/pages/dieta/sindieta/sindieta_widget.dart';
import '../../../gymhub/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dieta_page_model.dart';
export 'dieta_page_model.dart';

class DietaPageWidget extends StatefulWidget {
  const DietaPageWidget({super.key});

  static String routeName = 'dietaPage';
  static String routePath = '/dietaPage';

  @override
  State<DietaPageWidget> createState() => _DietaPageWidgetState();
}

class _DietaPageWidgetState extends State<DietaPageWidget> {
  late DietaPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DietaPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<GHAppState>();

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
                            'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85',
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
                              'Mi dieta',
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
                                'Este plan de dieta es generado con Inteligencia Artificial',
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
                      FutureBuilder<List<DietaRow>>(
                        future: DietaTable().querySingleRow(
                          queryFn: (q) => q.eqOrNull(
                            'usuario_id',
                            GHAppState().idUsuario,
                          ),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    GymHubTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<DietaRow> containerDietaRowList = snapshot.data!;

                          final containerDietaRow =
                              containerDietaRowList.isNotEmpty
                                  ? containerDietaRowList.first
                                  : null;

                          return Container(
                            decoration: BoxDecoration(),
                            child: FutureBuilder<List<DietaDiariaRow>>(
                              future: DietaDiariaTable().querySingleRow(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'dieta_id',
                                      containerDietaRow?.id,
                                    )
                                    .eqOrNull(
                                      'dia_semana',
                                      functions.obtenerdia(
                                          _model.calendarSelectedDay!.start),
                                    ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          GymHubTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<DietaDiariaRow>
                                    rutinaEjercicioQuerySingleDietaDiariaRowList =
                                    snapshot.data!;

                                final rutinaEjercicioQuerySingleDietaDiariaRow =
                                    rutinaEjercicioQuerySingleDietaDiariaRowList
                                            .isNotEmpty
                                        ? rutinaEjercicioQuerySingleDietaDiariaRowList
                                            .first
                                        : null;

                                return Container(
                                  decoration: BoxDecoration(),
                                  child: FutureBuilder<List<ComidasRow>>(
                                    future: ComidasTable().queryRows(
                                      queryFn: (q) => q.eqOrNull(
                                        'dieta_diaria_id',
                                        rutinaEjercicioQuerySingleDietaDiariaRow
                                            ?.id,
                                      ),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                GymHubTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<ComidasRow> columnComidasRowList =
                                          snapshot.data!;

                                      if (columnComidasRowList.isEmpty) {
                                        return SindietaWidget();
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            columnComidasRowList.length,
                                            (columnIndex) {
                                          final columnComidasRow =
                                              columnComidasRowList[columnIndex];
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .primaryBackground,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    valueOrDefault<String>(
                                                      () {
                                                        if (columnComidasRow
                                                                .tipoComida ==
                                                            'Almuerzo') {
                                                          return 'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85';
                                                        } else if (columnComidasRow
                                                                .tipoComida ==
                                                            'Desayuno') {
                                                          return 'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8YnJlYWtmYXN0fGVufDB8fHx8MTcyOTQxNzI4M3ww&ixlib=rb-4.0.3&q=80&w=400';
                                                        } else if (columnComidasRow
                                                                .tipoComida ==
                                                            'Cena') {
                                                          return 'https://images.unsplash.com/photo-1605926637512-c8b131444a4b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxEaW5uZXJ8ZW58MHx8fHwxNzI5NDI1NjYxfDA&ixlib=rb-4.0.3&q=80&w=400';
                                                        } else {
                                                          return 'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85';
                                                        }
                                                      }(),
                                                      'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85',
                                                    ),
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
                                                              DetalleDietaWidget(
                                                            comida:
                                                                columnComidasRow
                                                                    .id,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
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
                                                        Text(
                                                          'Tipo: ${columnComidasRow.tipoComida}',
                                                          style: GymHubTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                fontSize: 18.0,
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
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            columnComidasRow
                                                                .nombreComida,
                                                            'nombre_comida',
                                                          ),
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
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).divide(SizedBox(height: 16.0)),
                                      );
                                    },
                                  ),
                                );
                              },
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
