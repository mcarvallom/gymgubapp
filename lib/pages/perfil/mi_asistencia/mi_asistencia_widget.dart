import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_calendar.dart';
import '/gymhub/gymhub_icon_button.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mi_asistencia_model.dart';
export 'mi_asistencia_model.dart';

class MiAsistenciaWidget extends StatefulWidget {
  const MiAsistenciaWidget({super.key});

  static String routeName = 'miAsistencia';
  static String routePath = '/miAsistencia';

  @override
  State<MiAsistenciaWidget> createState() => _MiAsistenciaWidgetState();
}

class _MiAsistenciaWidgetState extends State<MiAsistenciaWidget> {
  late MiAsistenciaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MiAsistenciaModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ContactoRow>>(
      future: _model.sucursal(
        requestFn: () => ContactoTable().querySingleRow(
          queryFn: (q) => q,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: GymHubTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    GymHubTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<ContactoRow> miAsistenciaContactoRowList = snapshot.data!;

        final miAsistenciaContactoRow = miAsistenciaContactoRowList.isNotEmpty
            ? miAsistenciaContactoRowList.first
            : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: GymHubTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: GymHubTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GymHubIconButton(
                                  borderRadius: 10.0,
                                  buttonSize: 50.0,
                                  fillColor: Color(0x7FCDCDCD),
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: GymHubTheme.of(context).info,
                                    size: 25.0,
                                  ),
                                  onPressed: () async {
                                    context.safePop();
                                  },
                                ),
                                Text(
                                  dateTimeFormat(
                                    "d",
                                    _model.calendarSelectedDay!.start,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  style: GymHubTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              GymHubTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              GymHubTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 40.0,
                                        letterSpacing: 0.0,
                                        fontWeight: GymHubTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: GymHubTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dateTimeFormat(
                                        "MMMM",
                                        _model.calendarSelectedDay!.start,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      style: GymHubTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  GymHubTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  GymHubTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                GymHubTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                GymHubTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      dateTimeFormat(
                                        "EEEE",
                                        _model.calendarSelectedDay!.start,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      style: GymHubTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  GymHubTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  GymHubTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                GymHubTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                GymHubTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 6.0)),
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ),
                          ),
                          GymHubCalendar(
                            color: GymHubTheme.of(context).primary,
                            iconColor: GymHubTheme.of(context).primaryText,
                            weekFormat: true,
                            weekStartsMonday: true,
                            initialDate: getCurrentTimestamp,
                            rowHeight: 48.0,
                            onChange: (DateTimeRange? newSelectedDate) {
                              safeSetState(() =>
                                  _model.calendarSelectedDay = newSelectedDate);
                            },
                            titleStyle: GymHubTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: GymHubTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: GymHubTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                            dayOfWeekStyle:
                                GymHubTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: GymHubTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: GymHubTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: GymHubTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: GymHubTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                            dateStyle: GymHubTheme.of(context)
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
                            selectedDateStyle: GymHubTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: GymHubTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: GymHubTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: GymHubTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: GymHubTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
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
                                  fontWeight: GymHubTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: GymHubTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<AsistenciaRow>>(
                        future: _model.asistencia(
                          requestFn: () => AsistenciaTable().queryRows(
                            queryFn: (q) => q.eqOrNull(
                              'id_usuario',
                              currentUserUid,
                            ),
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
                          List<AsistenciaRow> containerAsistenciaRowList =
                              snapshot.data!;

                          return Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: GymHubTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Builder(
                                builder: (context) {
                                  final containerVar =
                                      containerAsistenciaRowList
                                          .where((e) =>
                                              dateTimeFormat(
                                                "d/M/y",
                                                _model
                                                    .calendarSelectedDay?.start,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              dateTimeFormat(
                                                "d/M/y",
                                                e.horaIngreso,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ))
                                          .toList();

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(containerVar.length,
                                        (containerVarIndex) {
                                      final containerVarItem =
                                          containerVar[containerVarIndex];
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          decoration: BoxDecoration(
                                            color: GymHubTheme.of(context)
                                                .primaryText,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: GymHubTheme.of(
                                                          context)
                                                      .lineColor,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0, 0.0,
                                                          16.0),
                                                  child: Text(
                                                    'Ingreso',
                                                    style: GymHubTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: GymHubTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Fecha: ${dateTimeFormat(
                                                          "d/M/y",
                                                          containerVarItem
                                                              .horaIngreso,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )}',
                                                        style:
                                                            GymHubTheme.of(
                                                                    context)
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
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .secondaryText,
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
                                                        'Hora ingreso: ${dateTimeFormat(
                                                          "Hm",
                                                          containerVarItem
                                                              .horaIngreso,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )}',
                                                        style:
                                                            GymHubTheme.of(
                                                                    context)
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
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .secondaryText,
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
                                                        'Dirección: ${miAsistenciaContactoRow?.direccion}',
                                                        style:
                                                            GymHubTheme.of(
                                                                    context)
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
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .secondaryText,
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
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).divide(SizedBox(height: 16.0)),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
