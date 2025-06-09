import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detalle_ejercicio_componente_model.dart';
export 'detalle_ejercicio_componente_model.dart';

class DetalleEjercicioComponenteWidget extends StatefulWidget {
  const DetalleEjercicioComponenteWidget({
    super.key,
    required this.ejericicio,
    this.planId,
    this.rutina,
  });

  final int? ejericicio;
  final int? planId;
  final int? rutina;

  @override
  State<DetalleEjercicioComponenteWidget> createState() =>
      _DetalleEjercicioComponenteWidgetState();
}

class _DetalleEjercicioComponenteWidgetState
    extends State<DetalleEjercicioComponenteWidget> {
  late DetalleEjercicioComponenteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetalleEjercicioComponenteModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(0.0),
        bottomRight: Radius.circular(0.0),
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: FutureBuilder<List<EjerciciosRow>>(
          future: EjerciciosTable().querySingleRow(
            queryFn: (q) => q.eqOrNull(
              'ejercicio_id',
              widget.ejericicio,
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
            List<EjerciciosRow> columnEjerciciosRowList = snapshot.data!;

            final columnEjerciciosRow = columnEjerciciosRowList.isNotEmpty
                ? columnEjerciciosRowList.first
                : null;

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1630174385546-6b9cbacd2bf1?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxnaW1uYXNpb3xlbnwwfHx8fDE3NDkwOTMzOTN8MA&ixlib=rb-4.1.0&q=85',
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 4.0,
                                    decoration: BoxDecoration(
                                      color: GymHubTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 200.0, 0.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: GymHubTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: FutureBuilder<List<PlanesEjercicioRow>>(
                                future: PlanesEjercicioTable().querySingleRow(
                                  queryFn: (q) => q.eqOrNull(
                                    'plan_id',
                                    widget.planId,
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
                                    child:
                                        FutureBuilder<List<RutinasDiariasRow>>(
                                      future:
                                          RutinasDiariasTable().querySingleRow(
                                        queryFn: (q) => q
                                            .eqOrNull(
                                              'plan_id',
                                              planEjercicioQuerySinglePlanesEjercicioRow
                                                  ?.planId,
                                            )
                                            .eqOrNull(
                                              'rutina_id',
                                              widget.rutina,
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  GymHubTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<RutinasDiariasRow>
                                            columnRutinasDiariasRowList =
                                            snapshot.data!;

                                        final columnRutinasDiariasRow =
                                            columnRutinasDiariasRowList
                                                    .isNotEmpty
                                                ? columnRutinasDiariasRowList
                                                    .first
                                                : null;

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FutureBuilder<
                                                List<EjerciciosRutinaRow>>(
                                              future: EjerciciosRutinaTable()
                                                  .querySingleRow(
                                                queryFn: (q) => q.eqOrNull(
                                                  'rutina_id',
                                                  columnRutinasDiariasRow
                                                      ?.rutinaId,
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
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
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    decoration: BoxDecoration(
                                                      color: GymHubTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            child: FutureBuilder<
                                                                List<
                                                                    EjerciciosRow>>(
                                                              future: EjerciciosTable()
                                                                  .querySingleRow(
                                                                queryFn: (q) =>
                                                                    q.eqOrNull(
                                                                  'ejercicio_id',
                                                                  containerEjerciciosRutinaRow
                                                                      ?.ejercicioId,
                                                                ),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          GymHubTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<EjerciciosRow>
                                                                    textEjerciciosRowList =
                                                                    snapshot
                                                                        .data!;

                                                                final textEjerciciosRow =
                                                                    textEjerciciosRowList
                                                                            .isNotEmpty
                                                                        ? textEjerciciosRowList
                                                                            .first
                                                                        : null;

                                                                return Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    textEjerciciosRow
                                                                        ?.nombre,
                                                                    'nombre',
                                                                  ),
                                                                  style: GymHubTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: GymHubTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          16.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .watch_later_outlined,
                                                                        color: GymHubTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      Text(
                                                                        '${valueOrDefault<String>(
                                                                          planEjercicioQuerySinglePlanesEjercicioRow
                                                                              ?.duracionSesionMin
                                                                              .toString(),
                                                                          '1',
                                                                        )} min',
                                                                        style: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .restart_alt,
                                                                        color: GymHubTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      Text(
                                                                        '${containerEjerciciosRutinaRow?.repeticiones} repeticiones',
                                                                        style: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .sports_gymnastics,
                                                                        color: GymHubTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      Text(
                                                                        '${containerEjerciciosRutinaRow?.series?.toString()} series',
                                                                        style: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        10.0)),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                if (columnEjerciciosRow
                                                                            ?.descripcion !=
                                                                        null &&
                                                                    columnEjerciciosRow
                                                                            ?.descripcion !=
                                                                        '')
                                                                  FutureBuilder<
                                                                      List<
                                                                          EjerciciosRow>>(
                                                                    future: EjerciciosTable()
                                                                        .querySingleRow(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'ejercicio_id',
                                                                        containerEjerciciosRutinaRow
                                                                            ?.ejercicioId,
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                GymHubTheme.of(context).primary,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<EjerciciosRow>
                                                                          textEjerciciosRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      final textEjerciciosRow = textEjerciciosRowList
                                                                              .isNotEmpty
                                                                          ? textEjerciciosRowList
                                                                              .first
                                                                          : null;

                                                                      return Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          textEjerciciosRow
                                                                              ?.descripcion,
                                                                          'descripcion',
                                                                        ),
                                                                        style: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      );
                                                                    },
                                                                  ),
                                                                Text(
                                                                  'Objetivo: ${planEjercicioQuerySinglePlanesEjercicioRow?.objetivo}',
                                                                  style: GymHubTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  'Enfoque: ${columnRutinasDiariasRow?.enfoque}',
                                                                  style: GymHubTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                if (containerEjerciciosRutinaRow
                                                                            ?.notas !=
                                                                        null &&
                                                                    containerEjerciciosRutinaRow
                                                                            ?.notas !=
                                                                        '')
                                                                  Text(
                                                                    'Notas: ${containerEjerciciosRutinaRow?.notas}',
                                                                    style: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              20.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 16.0))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height:
                                                                        16.0))
                                                            .addToEnd(SizedBox(
                                                                height: 16.0)),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
