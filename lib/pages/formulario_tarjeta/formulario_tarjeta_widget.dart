import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import '/gymhub/gymhub_widgets.dart';
import 'dart:ui';
import '../../gymhub/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'formulario_tarjeta_model.dart';
export 'formulario_tarjeta_model.dart';

class FormularioTarjetaWidget extends StatefulWidget {
  const FormularioTarjetaWidget({super.key});

  @override
  State<FormularioTarjetaWidget> createState() =>
      _FormularioTarjetaWidgetState();
}

class _FormularioTarjetaWidgetState extends State<FormularioTarjetaWidget> {
  late FormularioTarjetaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormularioTarjetaModel());

    _model.numTarjetaTextController1 ??= TextEditingController();
    _model.numTarjetaFocusNode1 ??= FocusNode();

    _model.mesTarjetaTextController ??= TextEditingController();
    _model.mesTarjetaFocusNode ??= FocusNode();

    _model.annioTarjetaTextController ??= TextEditingController();
    _model.annioTarjetaFocusNode ??= FocusNode();

    _model.cvvTarjetaTextController ??= TextEditingController();
    _model.cvvTarjetaFocusNode ??= FocusNode();

    _model.numTarjetaTextController2 ??= TextEditingController();
    _model.numTarjetaFocusNode2 ??= FocusNode();

    _model.runTextController ??= TextEditingController();
    _model.runFocusNode ??= FocusNode();

    _model.dvTextController ??= TextEditingController();
    _model.dvFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 2.0,
      ),
      child: FutureBuilder<List<MembresiaRow>>(
        future: _model.membresia(
          requestFn: () => MembresiaTable().querySingleRow(
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
          List<MembresiaRow> containerMembresiaRowList = snapshot.data!;

          final containerMembresiaRow = containerMembresiaRowList.isNotEmpty
              ? containerMembresiaRowList.first
              : null;

          return Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(
              color: Color(0x868B8B8B),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: FutureBuilder<List<PlanGimnasioRow>>(
                      future: _model.plan(
                        uniqueQueryKey: containerMembresiaRow?.idPlan,
                        requestFn: () => PlanGimnasioTable().querySingleRow(
                          queryFn: (q) => q.eqOrNull(
                            'id_plan',
                            containerMembresiaRow?.idPlan,
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
                        List<PlanGimnasioRow> cardCommentPlanGimnasioRowList =
                            snapshot.data!;

                        final cardCommentPlanGimnasioRow =
                            cardCommentPlanGimnasioRowList.isNotEmpty
                                ? cardCommentPlanGimnasioRowList.first
                                : null;

                        return Container(
                          width: 400.0,
                          decoration: BoxDecoration(
                            color: GymHubTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: GymHubTheme.of(context).primary,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 8.0, 12.0, 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 8.0, 10.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Pagar plan',
                                          style: GymHubTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      GymHubTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      GymHubTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    GymHubTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    GymHubTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                                Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color: GymHubTheme.of(context).primary,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          cardCommentPlanGimnasioRow
                                              ?.nombrePlan,
                                          'Nombre plan',
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
                                        ' - ',
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
                                        '\$${functions.ponerPuntoalMil(cardCommentPlanGimnasioRow!.precio.toString())}',
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
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        child: TextFormField(
                                          controller:
                                              _model.numTarjetaTextController1,
                                          focusNode:
                                              _model.numTarjetaFocusNode1,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelText: 'Número tarjeta',
                                            labelStyle:
                                                GymHubTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            hintText: 'Número tarjeta',
                                            hintStyle:
                                                GymHubTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .lineColor,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                GymHubTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                          style: GymHubTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      GymHubTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      GymHubTheme.of(
                                                              context)
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
                                          maxLength: 19,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          buildCounter: (context,
                                                  {required currentLength,
                                                  required isFocused,
                                                  maxLength}) =>
                                              null,
                                          keyboardType: TextInputType.number,
                                          cursorColor:
                                              GymHubTheme.of(context)
                                                  .primaryText,
                                          validator: _model
                                              .numTarjetaTextController1Validator
                                              .asValidator(context),
                                          inputFormatters: [
                                            _model.numTarjetaMask1
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .mesTarjetaTextController,
                                                      focusNode: _model
                                                          .mesTarjetaFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelText: 'Mes',
                                                        labelStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText: 'Mes',
                                                        hintStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: GymHubTheme
                                                                    .of(context)
                                                                .lineColor,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: GymHubTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: GymHubTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: GymHubTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
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
                                                      maxLength: 2,
                                                      maxLengthEnforcement:
                                                          MaxLengthEnforcement
                                                              .enforced,
                                                      buildCounter: (context,
                                                              {required currentLength,
                                                              required isFocused,
                                                              maxLength}) =>
                                                          null,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      cursorColor:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .mesTarjetaTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        _model.mesTarjetaMask
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '/',
                                                  style: GymHubTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .annioTarjetaTextController,
                                                      focusNode: _model
                                                          .annioTarjetaFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelText: 'Año',
                                                        labelStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText: 'Año',
                                                        hintStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: GymHubTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: GymHubTheme
                                                                    .of(context)
                                                                .lineColor,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: GymHubTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: GymHubTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: GymHubTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
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
                                                      maxLength: 2,
                                                      maxLengthEnforcement:
                                                          MaxLengthEnforcement
                                                              .enforced,
                                                      buildCounter: (context,
                                                              {required currentLength,
                                                              required isFocused,
                                                              maxLength}) =>
                                                          null,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      cursorColor:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .annioTarjetaTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        _model.annioTarjetaMask
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 8.0)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              child: TextFormField(
                                                controller: _model
                                                    .cvvTarjetaTextController,
                                                focusNode:
                                                    _model.cvvTarjetaFocusNode,
                                                autofocus: false,
                                                obscureText: !_model
                                                    .cvvTarjetaVisibility,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'CVV',
                                                  labelStyle: GymHubTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  hintText: 'CVV',
                                                  hintStyle: GymHubTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .lineColor,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      GymHubTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  suffixIcon: InkWell(
                                                    onTap: () => safeSetState(
                                                      () => _model
                                                              .cvvTarjetaVisibility =
                                                          !_model
                                                              .cvvTarjetaVisibility,
                                                    ),
                                                    focusNode: FocusNode(
                                                        skipTraversal: true),
                                                    child: Icon(
                                                      _model.cvvTarjetaVisibility
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                                style:
                                                    GymHubTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                maxLength: 3,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                                buildCounter: (context,
                                                        {required currentLength,
                                                        required isFocused,
                                                        maxLength}) =>
                                                    null,
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor:
                                                    GymHubTheme.of(context)
                                                        .primaryText,
                                                validator: _model
                                                    .cvvTarjetaTextControllerValidator
                                                    .asValidator(context),
                                                inputFormatters: [
                                                  _model.cvvTarjetaMask
                                                ],
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        child: TextFormField(
                                          controller:
                                              _model.numTarjetaTextController2,
                                          focusNode:
                                              _model.numTarjetaFocusNode2,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelText: 'Nombre titular tarjeta',
                                            labelStyle:
                                                GymHubTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            hintText: 'Nombre titular tarjeta',
                                            hintStyle:
                                                GymHubTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .lineColor,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    GymHubTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                GymHubTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                          style: GymHubTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      GymHubTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      GymHubTheme.of(
                                                              context)
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
                                          cursorColor:
                                              GymHubTheme.of(context)
                                                  .primaryText,
                                          validator: _model
                                              .numTarjetaTextController2Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              child: TextFormField(
                                                controller:
                                                    _model.runTextController,
                                                focusNode: _model.runFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Run',
                                                  labelStyle: GymHubTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  hintText: 'Run',
                                                  hintStyle: GymHubTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .lineColor,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      GymHubTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                ),
                                                style:
                                                    GymHubTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                maxLength: 8,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                                buildCounter: (context,
                                                        {required currentLength,
                                                        required isFocused,
                                                        maxLength}) =>
                                                    null,
                                                keyboardType:
                                                    TextInputType.number,
                                                cursorColor:
                                                    GymHubTheme.of(context)
                                                        .primaryText,
                                                validator: _model
                                                    .runTextControllerValidator
                                                    .asValidator(context),
                                                inputFormatters: [
                                                  _model.runMask
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              child: TextFormField(
                                                controller:
                                                    _model.dvTextController,
                                                focusNode: _model.dvFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Dv',
                                                  labelStyle: GymHubTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  hintText: 'Dv',
                                                  hintStyle: GymHubTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            GymHubTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .lineColor,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          GymHubTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      GymHubTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                ),
                                                style:
                                                    GymHubTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              GymHubTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                maxLength: 1,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                                buildCounter: (context,
                                                        {required currentLength,
                                                        required isFocused,
                                                        maxLength}) =>
                                                    null,
                                                cursorColor:
                                                    GymHubTheme.of(context)
                                                        .primaryText,
                                                validator: _model
                                                    .dvTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ].divide(SizedBox(height: 20.0)),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: GHButtonWidget(
                                    onPressed: () async {
                                      _model.generarTokenTarjeta =
                                          await MercadopagoGroup.crearTokenCall
                                              .call(
                                        cardNumber: _model
                                            .numTarjetaTextController1.text,
                                        cardExpirationMonth: _model
                                            .mesTarjetaTextController.text,
                                        cardExpirationYear: _model
                                            .annioTarjetaTextController.text,
                                        securityCode: _model
                                            .cvvTarjetaTextController.text,
                                        cardholderName: _model
                                            .numTarjetaTextController2.text,
                                        identificationNumber:
                                            '${_model.runTextController.text}-${_model.dvTextController.text}',
                                      );

                                      _model.crearPago = await MercadopagoGroup
                                          .procesarPagoCall
                                          .call(
                                        token: getJsonField(
                                          (_model.generarTokenTarjeta
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.id''',
                                        ).toString(),
                                        email: currentUserEmail,
                                        number:
                                            '${_model.runTextController.text}-${_model.dvTextController.text}',
                                        transactionAmount:
                                            cardCommentPlanGimnasioRow.precio
                                                .toString(),
                                      );

                                      if (MercadopagoGroup.procesarPagoCall
                                              .estado(
                                            (_model.crearPago?.jsonBody ?? ''),
                                          ) ==
                                          'approved') {
                                        Navigator.pop(context);
                                        await PagoTable().insert({
                                          'fecha_pago': supaSerialize<DateTime>(
                                              getCurrentTimestamp),
                                          'id_usuario': currentUserUid,
                                          'monto': cardCommentPlanGimnasioRow
                                              .precio,
                                          'estado':
                                              '4b0a9254-2a4d-414f-873c-9f085c68fa07',
                                          'medio_de_pago':
                                              '1e9c90d1-c3dd-47ef-9cbb-be854c72f91c',
                                          'id_membresia':
                                              containerMembresiaRow?.id,
                                        });
                                        await MembresiaTable().update(
                                          data: {
                                            'fecha_inicio':
                                                supaSerialize<DateTime>(
                                                    getCurrentTimestamp),
                                            'estado':
                                                '047930a7-0dd1-4885-92da-7a849d353e9a',
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            containerMembresiaRow?.id,
                                          ),
                                        );
                                        GHAppState().estado =
                                            '047930a7-0dd1-4885-92da-7a849d353e9a';
                                        safeSetState(() {});

                                        context.pushNamed(
                                          InicioWidget.routeName,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      } else if ((MercadopagoGroup
                                                  .procesarPagoCall
                                                  .estado(
                                                (_model.crearPago?.jsonBody ??
                                                    ''),
                                              ) ==
                                              'rejected') ||
                                          (MercadopagoGroup.procesarPagoCall
                                                  .estado(
                                                (_model.crearPago?.jsonBody ??
                                                    ''),
                                              ) ==
                                              'in_mediation') ||
                                          (MercadopagoGroup.procesarPagoCall
                                                  .estado(
                                                (_model.crearPago?.jsonBody ??
                                                    ''),
                                              ) ==
                                              'cancelled') ||
                                          (MercadopagoGroup.procesarPagoCall
                                                  .estado(
                                                (_model.crearPago?.jsonBody ??
                                                    ''),
                                              ) ==
                                              'refunded')) {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Ups!'),
                                              content: Text('Error en el pago'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child:
                                                      Text('Intentar de nuevo'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Pagar',
                                    options: GHButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          GymHubTheme.of(context).primary,
                                      textStyle: GymHubTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  GymHubTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  GymHubTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: GymHubTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                GymHubTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                GymHubTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
