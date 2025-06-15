import 'package:gymhub_app/backend/supabase/database/tables/comida_ingredientes.dart';
import 'package:gymhub_app/backend/supabase/database/tables/comidas.dart';

import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/botones_paginas_nav_bar/botones_paginas_nav_bar_widget.dart';
import '../../../gymhub/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detalle_dieta_model.dart';
export 'detalle_dieta_model.dart';

class DetalleDietaWidget extends StatefulWidget {
  const DetalleDietaWidget({
    super.key,
    this.comida,
  });

  final int? comida;

  @override
  State<DetalleDietaWidget> createState() =>
      _DetalleDietaComponentWidgetState();
}

class _DetalleDietaComponentWidgetState
    extends State<DetalleDietaWidget> {
  late DetalleDietaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetalleDietaModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ComidasRow>>(
      future: ComidasTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id',
          widget.comida,
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
        List<ComidasRow> rutinaEjercicioQuerySingleComidasRowList =
            snapshot.data!;

        final rutinaEjercicioQuerySingleComidasRow =
            rutinaEjercicioQuerySingleComidasRowList.isNotEmpty
                ? rutinaEjercicioQuerySingleComidasRowList.first
                : null;

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
            child: FutureBuilder<List<DietaDiariaRow>>(
              future: DietaDiariaTable().querySingleRow(
                queryFn: (q) => q.eqOrNull(
                  'id',
                  rutinaEjercicioQuerySingleComidasRow?.dietaDiariaId,
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
                List<DietaDiariaRow> containerDietaDiariaRowList =
                    snapshot.data!;

                final containerDietaDiariaRow =
                    containerDietaDiariaRowList.isNotEmpty
                        ? containerDietaDiariaRowList.first
                        : null;

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(
                        valueOrDefault<String>(
                          () {
                            if (rutinaEjercicioQuerySingleComidasRow
                                    ?.tipoComida ==
                                'Almuerzo') {
                              return 'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85';
                            } else if (rutinaEjercicioQuerySingleComidasRow
                                    ?.tipoComida ==
                                'Desayuno') {
                              return 'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8YnJlYWtmYXN0fGVufDB8fHx8MTcyOTQxNzI4M3ww&ixlib=rb-4.0.3&q=80&w=400';
                            } else if (rutinaEjercicioQuerySingleComidasRow
                                    ?.tipoComida ==
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
                  ),
                  child: FutureBuilder<List<DietaRow>>(
                    future: DietaTable().querySingleRow(
                      queryFn: (q) => q.eqOrNull(
                        'id',
                        containerDietaDiariaRow?.dietaId,
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

                      final containerDietaRow = containerDietaRowList.isNotEmpty
                          ? containerDietaRowList.first
                          : null;

                      return ClipRRect(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xC7000000), Colors.transparent],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Container(
                                        width: 50.0,
                                        height: 4.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              () {
                                                if (rutinaEjercicioQuerySingleComidasRow
                                                        ?.tipoComida ==
                                                    'Almuerzo') {
                                                  return 'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85';
                                                } else if (rutinaEjercicioQuerySingleComidasRow
                                                        ?.tipoComida ==
                                                    'Desayuno') {
                                                  return 'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8YnJlYWtmYXN0fGVufDB8fHx8MTcyOTQxNzI4M3ww&ixlib=rb-4.0.3&q=80&w=400';
                                                } else if (rutinaEjercicioQuerySingleComidasRow
                                                        ?.tipoComida ==
                                                    'Cena') {
                                                  return 'https://images.unsplash.com/photo-1605926637512-c8b131444a4b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxEaW5uZXJ8ZW58MHx8fHwxNzI5NDI1NjYxfDA&ixlib=rb-4.0.3&q=80&w=400';
                                                } else {
                                                  return 'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85';
                                                }
                                              }(),
                                              'https://images.unsplash.com/photo-1565895405138-6c3a1555da6a?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8ZGlldGF8ZW58MHx8fHwxNzQ4OTExODk2fDA&ixlib=rb-4.1.0&q=85',
                                            ),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
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
                                              end: AlignmentDirectional(0, 1.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 100.0, 16.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tipo: ${rutinaEjercicioQuerySingleComidasRow?.tipoComida}',
                                                style:
                                                    GymHubTheme.of(context)
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
                                                          fontSize: 18.0,
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
                                              Text(
                                                valueOrDefault<String>(
                                                  rutinaEjercicioQuerySingleComidasRow
                                                      ?.nombreComida,
                                                  'titulo',
                                                ),
                                                style:
                                                    GymHubTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                              Text(
                                                'Enfoque: ${containerDietaDiariaRow?.enfoque}',
                                                style:
                                                    GymHubTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    FutureBuilder<List<ComidaIngredientesRow>>(
                                      future:
                                          ComidaIngredientesTable().queryRows(
                                        queryFn: (q) => q.eqOrNull(
                                          'dieta_diaria',
                                          rutinaEjercicioQuerySingleComidasRow
                                              ?.dietaDiariaId,
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
                                        List<ComidaIngredientesRow>
                                            containerComidaIngredientesRowList =
                                            snapshot.data!;

                                        return Container(
                                          decoration: BoxDecoration(
                                            color: GymHubTheme.of(context)
                                                .primaryBackground,
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
                                                      .secondaryBackground,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Wrap(
                                                    spacing: 16.0,
                                                    runSpacing: 16.0,
                                                    alignment: WrapAlignment
                                                        .spaceAround,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    direction: Axis.horizontal,
                                                    runAlignment: WrapAlignment
                                                        .spaceAround,
                                                    verticalDirection:
                                                        VerticalDirection.down,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'Calorías',
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
                                                            functions
                                                                .sumar(containerComidaIngredientesRowList
                                                                    .map((e) =>
                                                                        e.calorias)
                                                                    .withoutNulls
                                                                    .toList())
                                                                .toString(),
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
                                                            height: 8.0)),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'Grasas',
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
                                                            functions
                                                                .sumar(containerComidaIngredientesRowList
                                                                    .map((e) =>
                                                                        e.grasa)
                                                                    .withoutNulls
                                                                    .toList())
                                                                .toString(),
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
                                                            height: 8.0)),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'Carbohidratos',
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
                                                            functions
                                                                .sumar(containerComidaIngredientesRowList
                                                                    .map((e) =>
                                                                        e.carbohidratos)
                                                                    .withoutNulls
                                                                    .toList())
                                                                .toString(),
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
                                                            height: 8.0)),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'Proteina',
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
                                                            functions
                                                                .sumar(containerComidaIngredientesRowList
                                                                    .map((e) =>
                                                                        e.proteina)
                                                                    .withoutNulls
                                                                    .toList())
                                                                .toString(),
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
                                                            height: 8.0)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Preparación:',
                                                        style: GymHubTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  GymHubTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          containerDietaRow
                                                              ?.preparacion,
                                                          'preparacion',
                                                        ),
                                                        style: GymHubTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  GymHubTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (containerComidaIngredientesRowList
                                                                .isNotEmpty)
                                                              Text(
                                                                'Ingredientes:',
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
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: GymHubTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final containerVar =
                                                                    containerComidaIngredientesRowList
                                                                        .toList();

                                                                return SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: List.generate(
                                                                        containerVar
                                                                            .length,
                                                                        (containerVarIndex) {
                                                                      final containerVarItem =
                                                                          containerVar[
                                                                              containerVarIndex];
                                                                      return Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            6.0,
                                                                            0.0,
                                                                            6.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            containerVarItem.nombreIngrediente,
                                                                            'nombre_ingrediente',
                                                                          ),
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
                                                                      );
                                                                    }).divide(SizedBox(
                                                                        width:
                                                                            10.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 10.0)),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 16.0)),
                                                  ),
                                                ),
                                              ),
                                            ]
                                                .divide(SizedBox(height: 16.0))
                                                .addToEnd(
                                                    SizedBox(height: 16.0)),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
