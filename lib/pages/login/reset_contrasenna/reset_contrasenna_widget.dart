import 'package:gymhub_app/gymhub/gymhub_theme.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/gymhub/gymhub_util.dart';
import '/gymhub/gymhub_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reset_contrasenna_model.dart';
export 'reset_contrasenna_model.dart';

class ResetContrasennaWidget extends StatefulWidget {
  const ResetContrasennaWidget({super.key});

  static String routeName = 'resetContrasenna';
  static String routePath = '/resetContrasenna';

  @override
  State<ResetContrasennaWidget> createState() => _ResetContrasennaWidgetState();
}

class _ResetContrasennaWidgetState extends State<ResetContrasennaWidget> {
  late ResetContrasennaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetContrasennaModel());

    _model.contraseaTextController ??= TextEditingController();
    _model.contraseaFocusNode ??= FocusNode();

    _model.confirmContraseaTextController ??= TextEditingController();
    _model.confirmContraseaFocusNode ??= FocusNode();
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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ingresa tu nueva contraseña',
                    style: GymHubTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: GymHubTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: GymHubTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: GymHubTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              GymHubTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    child: TextFormField(
                      controller: _model.contraseaTextController,
                      focusNode: _model.contraseaFocusNode,
                      autofocus: false,
                      obscureText: !_model.contraseaVisibility,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Contraseña',
                        labelStyle: GymHubTheme.of(context)
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
                              color: GymHubTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: GymHubTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: GymHubTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                        alignLabelWithHint: false,
                        hintStyle:
                            GymHubTheme.of(context).labelMedium.override(
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: GymHubTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: GymHubTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor:
                            GymHubTheme.of(context).secondaryBackground,
                        suffixIcon: InkWell(
                          onTap: () => safeSetState(
                            () => _model.contraseaVisibility =
                                !_model.contraseaVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            _model.contraseaVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: GymHubTheme.of(context).primaryText,
                            size: 22,
                          ),
                        ),
                      ),
                      style: GymHubTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: GymHubTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: GymHubTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: GymHubTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: GymHubTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                      cursorColor: GymHubTheme.of(context).primaryText,
                      validator: _model.contraseaTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    child: TextFormField(
                      controller: _model.confirmContraseaTextController,
                      focusNode: _model.confirmContraseaFocusNode,
                      autofocus: false,
                      obscureText: !_model.confirmContraseaVisibility,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Confirmar Contraseña',
                        labelStyle: GymHubTheme.of(context)
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
                              color: GymHubTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: GymHubTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: GymHubTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                        alignLabelWithHint: false,
                        hintStyle:
                            GymHubTheme.of(context).labelMedium.override(
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: GymHubTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: GymHubTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor:
                            GymHubTheme.of(context).secondaryBackground,
                        suffixIcon: InkWell(
                          onTap: () => safeSetState(
                            () => _model.confirmContraseaVisibility =
                                !_model.confirmContraseaVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            _model.confirmContraseaVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: GymHubTheme.of(context).primaryText,
                            size: 22,
                          ),
                        ),
                      ),
                      style: GymHubTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: GymHubTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: GymHubTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: GymHubTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: GymHubTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                      cursorColor: GymHubTheme.of(context).primaryText,
                      validator: _model.confirmContraseaTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  GHButtonWidget(
                    onPressed: () async {
                      await authManager.updatePassword(
                        newPassword: _model.contraseaTextController.text,
                        context: context,
                      );
                      safeSetState(() {});

                      context.goNamedAuth(
                          InicioWidget.routeName, context.mounted);
                    },
                    text: 'Cambiar',
                    options: GHButtonOptions(
                      width: 150.0,
                      height: 45.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: GymHubTheme.of(context).primary,
                      textStyle: GymHubTheme.of(context)
                          .titleSmall
                          .override(
                            font: GoogleFonts.interTight(
                              fontWeight: FontWeight.normal,
                              fontStyle: GymHubTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: GymHubTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: GymHubTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
