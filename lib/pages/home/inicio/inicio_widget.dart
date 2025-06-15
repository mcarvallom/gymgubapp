import 'package:gymhub_app/backend/supabase/database/tables/comidas.dart';
import 'package:provider/provider.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/home/sinejercicios/sinejercicios_widget.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '../../../gymhub/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inicio_model.dart';
export 'inicio_model.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});

  static String routeName = 'inicio';
  static String routePath = '/inicio';

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  late InicioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InicioModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await action_blocks.membresia(context);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<GHAppState>();

    return FutureBuilder<List<UsuarioRow>>(
      future: _model.usuario(
        uniqueQueryKey: GHAppState().idUsuario,
        requestFn: () => UsuarioTable().querySingleRow(
          queryFn: (q) => q.eqOrNull(
            'id_usuario',
            GHAppState().idUsuario,
          ),
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: GymHubTheme.of(context).primaryBackground,
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
        List<UsuarioRow> inicioUsuarioRowList = snapshot.data!;

        final inicioUsuarioRow =
            inicioUsuarioRowList.isNotEmpty ? inicioUsuarioRowList.first : null;

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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/logoTransparenteGymHubBlanco.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hola ',
                                    style: GymHubTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w300,
                                            fontStyle:
                                                GymHubTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 36.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w300,
                                          fontStyle:
                                              GymHubTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  TextSpan(
                                    text: inicioUsuarioRow!.nombre,
                                    style: GymHubTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                GymHubTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 36.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              GymHubTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  )
                                ],
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
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ejercicios de hoy',
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
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  EjerciciosPageWidget.routeName,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              },
                              child: Text(
                                'Mirar todo',
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
                                      color:
                                          GymHubTheme.of(context).primary,
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
                          ],
                        ),
                      ),
                      FutureBuilder<List<PlanesEjercicioRow>>(
                        future: PlanesEjercicioTable().querySingleRow(
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
                            child: FutureBuilder<List<RutinasDiariasRow>>(
                              future: RutinasDiariasTable().queryRows(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'plan_id',
                                      planEjercicioQuerySinglePlanesEjercicioRow
                                          ?.planId,
                                    )
                                    .eqOrNull(
                                      'dia_semana',
                                      functions.obtenerdia(getCurrentTimestamp),
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
                                List<RutinasDiariasRow>
                                    rutinaEjercicioQuerySingleRutinasDiariasRowList =
                                    snapshot.data!;

                                return Container(
                                  decoration: BoxDecoration(),
                                  child: Builder(
                                    builder: (context) {
                                      if (rutinaEjercicioQuerySingleRutinasDiariasRowList
                                                  .firstOrNull?.diaSemana !=
                                              null &&
                                          rutinaEjercicioQuerySingleRutinasDiariasRowList
                                                  .firstOrNull?.diaSemana !=
                                              '') {
                                        return FutureBuilder<
                                            List<EjerciciosRutinaRow>>(
                                          future:
                                              EjerciciosRutinaTable().queryRows(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'rutina_id',
                                                  rutinaEjercicioQuerySingleRutinasDiariasRowList
                                                      .firstOrNull?.rutinaId,
                                                )
                                                .order('rutina_id',
                                                    ascending: true),
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

                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: GymHubTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(
                                                      'https://images.unsplash.com/photo-1549476464-37392f717541?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8Z3ltJTIwY29hY2h8ZW58MHx8fHwxNzI5NDI1MTI2fDA&ixlib=rb-4.0.3&q=80&w=1080',
                                                    ).image,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                    color: GymHubTheme.of(
                                                            context)
                                                        .lineColor,
                                                    width: 1.0,
                                                  ),
                                                ),
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
                                                              EjerciciosTable()
                                                                  .querySingleRow(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'ejercicio_id',
                                                              containerEjerciciosRutinaRowList
                                                                  .firstOrNull
                                                                  ?.ejercicioId,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                          'Enfoque: ${rutinaEjercicioQuerySingleRutinasDiariasRowList.firstOrNull?.enfoque}',
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
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return wrapWithModel(
                                          model: _model.sinejerciciosModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: SinejerciciosWidget(),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 32.0, 0.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mi dieta diaria',
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
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  DietaPageWidget.routeName,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              },
                              child: Text(
                                'Mirar todo',
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
                                      color:
                                          GymHubTheme.of(context).primary,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 1.0),
                                child: FutureBuilder<List<DietaRow>>(
                                  future: _model.dietasdesayuno(
                                    requestFn: () =>
                                        DietaTable().querySingleRow(
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
                                    List<DietaRow> dietaDietaRowList =
                                        snapshot.data!;

                                    final dietaDietaRow =
                                        dietaDietaRowList.isNotEmpty
                                            ? dietaDietaRowList.first
                                            : null;

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: GymHubTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                            'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8YnJlYWtmYXN0fGVufDB8fHx8MTcyOTQxNzI4M3ww&ixlib=rb-4.0.3&q=80&w=400',
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child:
                                          FutureBuilder<List<DietaDiariaRow>>(
                                        future: _model.dietasdiarias(
                                          requestFn: () =>
                                              DietaDiariaTable().querySingleRow(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'dieta_id',
                                                  dietaDietaRow?.id,
                                                )
                                                .eqOrNull(
                                                  'dia_semana',
                                                  functions.obtenerdia(
                                                      getCurrentTimestamp),
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
                                                child:
                                                    CircularProgressIndicator(
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
                                          List<DietaDiariaRow>
                                              dietaDiariaDietaDiariaRowList =
                                              snapshot.data!;

                                          final dietaDiariaDietaDiariaRow =
                                              dietaDiariaDietaDiariaRowList
                                                      .isNotEmpty
                                                  ? dietaDiariaDietaDiariaRowList
                                                      .first
                                                  : null;

                                          return Container(
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0x00FFFFFF),
                                                  Color(0xC0000000)
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    0.0, -1.0),
                                                end: AlignmentDirectional(
                                                    0, 1.0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child:
                                                FutureBuilder<List<ComidasRow>>(
                                              future: ComidasTable().queryRows(
                                                queryFn: (q) => q
                                                    .eqOrNull(
                                                      'tipo_comida',
                                                      'Desayuno',
                                                    )
                                                    .eqOrNull(
                                                      'dieta_diaria_id',
                                                      dietaDiariaDietaDiariaRow
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
                                                List<ComidasRow>
                                                    containerComidasRowList =
                                                    snapshot.data!;

                                                return Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                10.0,
                                                                10.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (containerComidasRowList
                                                                .length >
                                                            0) {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            useSafeArea: true,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      DetalleDietaWidget(
                                                                    comida: containerComidasRowList
                                                                        .firstOrNull
                                                                        ?.id,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Desayuno',
                                                                style: GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: GymHubTheme.of(context)
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
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          4.0,
                                                                      height:
                                                                          16.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: GymHubTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${containerComidasRowList.length.toString()} opciones',
                                                                    style: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              GymHubTheme.of(context).primary,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
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
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: GymHubTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'Comenzar',
                                                                          style: GymHubTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 16.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 1.0),
                                child: FutureBuilder<List<DietaRow>>(
                                  future: _model.dietasalmuerzo(
                                    requestFn: () =>
                                        DietaTable().querySingleRow(
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
                                    List<DietaRow> dieta2DietaRowList =
                                        snapshot.data!;

                                    final dieta2DietaRow =
                                        dieta2DietaRowList.isNotEmpty
                                            ? dieta2DietaRowList.first
                                            : null;

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: GymHubTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                            'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85',
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child:
                                          FutureBuilder<List<DietaDiariaRow>>(
                                        future: _model.dietasdiariasAlmuerzo(
                                          requestFn: () =>
                                              DietaDiariaTable().querySingleRow(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'dieta_id',
                                                  dieta2DietaRow?.id,
                                                )
                                                .eqOrNull(
                                                  'dia_semana',
                                                  functions.obtenerdia(
                                                      getCurrentTimestamp),
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
                                                child:
                                                    CircularProgressIndicator(
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
                                          List<DietaDiariaRow>
                                              dietaDiaria2DietaDiariaRowList =
                                              snapshot.data!;

                                          final dietaDiaria2DietaDiariaRow =
                                              dietaDiaria2DietaDiariaRowList
                                                      .isNotEmpty
                                                  ? dietaDiaria2DietaDiariaRowList
                                                      .first
                                                  : null;

                                          return Container(
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    0.0, -1.0),
                                                end: AlignmentDirectional(
                                                    0, 1.0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child:
                                                FutureBuilder<List<ComidasRow>>(
                                              future: ComidasTable().queryRows(
                                                queryFn: (q) => q
                                                    .eqOrNull(
                                                      'tipo_comida',
                                                      'Almuerzo',
                                                    )
                                                    .eqOrNull(
                                                      'dieta_diaria_id',
                                                      dietaDiaria2DietaDiariaRow
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
                                                List<ComidasRow>
                                                    containerComidasRowList =
                                                    snapshot.data!;

                                                return Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                10.0,
                                                                10.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (containerComidasRowList
                                                                .length >
                                                            0) {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            useSafeArea: true,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      DetalleDietaWidget(
                                                                    comida: containerComidasRowList
                                                                        .firstOrNull
                                                                        ?.id,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Almuerzo',
                                                                style: GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: GymHubTheme.of(context)
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
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          4.0,
                                                                      height:
                                                                          16.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: GymHubTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${containerComidasRowList.length.toString()} opciones',
                                                                    style: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              GymHubTheme.of(context).primary,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
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
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: GymHubTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'Comenzar',
                                                                          style: GymHubTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 16.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 1.0),
                                child: FutureBuilder<List<DietaRow>>(
                                  future: _model.dietasCena(
                                    requestFn: () =>
                                        DietaTable().querySingleRow(
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
                                    List<DietaRow> dietaTresDietaRowList =
                                        snapshot.data!;

                                    final dietaTresDietaRow =
                                        dietaTresDietaRowList.isNotEmpty
                                            ? dietaTresDietaRowList.first
                                            : null;

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: GymHubTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                            'https://images.unsplash.com/photo-1605926637512-c8b131444a4b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxEaW5uZXJ8ZW58MHx8fHwxNzI5NDI1NjYxfDA&ixlib=rb-4.0.3&q=80&w=400',
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child:
                                          FutureBuilder<List<DietaDiariaRow>>(
                                        future: _model.dietasdiariasCena(
                                          requestFn: () =>
                                              DietaDiariaTable().querySingleRow(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'dieta_id',
                                                  dietaTresDietaRow?.id,
                                                )
                                                .eqOrNull(
                                                  'dia_semana',
                                                  functions.obtenerdia(
                                                      getCurrentTimestamp),
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
                                                child:
                                                    CircularProgressIndicator(
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
                                          List<DietaDiariaRow>
                                              dietaDiaria3DietaDiariaRowList =
                                              snapshot.data!;

                                          final dietaDiaria3DietaDiariaRow =
                                              dietaDiaria3DietaDiariaRowList
                                                      .isNotEmpty
                                                  ? dietaDiaria3DietaDiariaRowList
                                                      .first
                                                  : null;

                                          return Container(
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0x00FFFFFF),
                                                  Color(0xC0000000)
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    0.0, -1.0),
                                                end: AlignmentDirectional(
                                                    0, 1.0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child:
                                                FutureBuilder<List<ComidasRow>>(
                                              future: ComidasTable().queryRows(
                                                queryFn: (q) => q
                                                    .eqOrNull(
                                                      'tipo_comida',
                                                      'Cena',
                                                    )
                                                    .eqOrNull(
                                                      'dieta_diaria_id',
                                                      dietaDiaria3DietaDiariaRow
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
                                                List<ComidasRow>
                                                    containerComidasRowList =
                                                    snapshot.data!;

                                                return Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                10.0,
                                                                10.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (containerComidasRowList
                                                                .length >
                                                            0) {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            useSafeArea: true,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      DetalleDietaWidget(
                                                                    comida: containerComidasRowList
                                                                        .firstOrNull
                                                                        ?.id,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Cena',
                                                                style: GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: GymHubTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: GymHubTheme.of(context)
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
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          4.0,
                                                                      height:
                                                                          16.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: GymHubTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${containerComidasRowList.length.toString()} opciones',
                                                                    style: GymHubTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                GymHubTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              GymHubTheme.of(context).primary,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
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
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: GymHubTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'Comenzar',
                                                                          style: GymHubTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: GymHubTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 16.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 16.0))
                        .addToEnd(SizedBox(height: 48.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
