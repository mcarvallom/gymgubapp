import 'package:gymhub_app/gymhub/gymhub_theme.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/gymhub/gymhub_util.dart';
import '/gymhub/gymhub_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'login';
  static String routePath = '/login';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 1,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.contraseaTextController ??= TextEditingController();
    _model.contraseaFocusNode ??= FocusNode();
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: GymHubTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: GymHubTheme.of(context).lineColor,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/logoTransparenteGymHubBlanco.png',
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 300.0,
                                constraints: BoxConstraints(
                                  maxHeight: 400.0,
                                ),
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, 0),
                                      child: TabBar(
                                        labelColor: GymHubTheme.of(context)
                                            .primaryText,
                                        unselectedLabelColor:
                                            GymHubTheme.of(context)
                                                .secondaryText,
                                        labelStyle: GymHubTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    GymHubTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  GymHubTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                        unselectedLabelStyle: GymHubTheme
                                                .of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    GymHubTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  GymHubTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                        indicatorColor:
                                            GymHubTheme.of(context)
                                                .lineColor,
                                        indicatorWeight: 1.0,
                                        tabs: [
                                          Tab(
                                            text: 'Entrar',
                                          ),
                                        ],
                                        controller: _model.tabBarController,
                                        onTap: (i) async {
                                          [() async {}][i]();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: Form(
                                                    key: _model.formKey,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .disabled,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .emailTextController,
                                                            focusNode: _model
                                                                .emailFocusNode,
                                                            autofocus: false,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Email',
                                                              labelStyle:
                                                                  GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: GymHubTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              alignLabelWithHint:
                                                                  false,
                                                              hintStyle:
                                                                  GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
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
                                                                            20.0),
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
                                                                            20.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: GymHubTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
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
                                                                  fontSize:
                                                                      16.0,
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
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                            minLines: 1,
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            cursorColor:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .emailTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .contraseaTextController,
                                                            focusNode: _model
                                                                .contraseaFocusNode,
                                                            onFieldSubmitted:
                                                                (_) async {
                                                              if (_model.formKey
                                                                          .currentState ==
                                                                      null ||
                                                                  !_model
                                                                      .formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                return;
                                                              }
                                                              GoRouter.of(
                                                                      context)
                                                                  .prepareAuthEvent();

                                                              final user =
                                                                  await authManager
                                                                      .signInWithEmail(
                                                                context,
                                                                _model
                                                                    .emailTextController
                                                                    .text,
                                                                _model
                                                                    .contraseaTextController
                                                                    .text,
                                                              );
                                                              if (user ==
                                                                  null) {
                                                                return;
                                                              }

                                                              GHAppState()
                                                                      .idUsuario =
                                                                  currentUserUid;
                                                              GHAppState()
                                                                      .email =
                                                                  currentUserEmail;
                                                              safeSetState(
                                                                  () {});

                                                              context.goNamedAuth(
                                                                  InicioWidget
                                                                      .routeName,
                                                                  context
                                                                      .mounted);
                                                            },
                                                            autofocus: false,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .go,
                                                            obscureText: !_model
                                                                .contraseaVisibility,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Contraseña',
                                                              labelStyle:
                                                                  GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: GymHubTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              alignLabelWithHint:
                                                                  false,
                                                              hintStyle:
                                                                  GymHubTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: GymHubTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
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
                                                                            20.0),
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
                                                                            20.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: GymHubTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              suffixIcon:
                                                                  InkWell(
                                                                onTap: () =>
                                                                    safeSetState(
                                                                  () => _model
                                                                          .contraseaVisibility =
                                                                      !_model
                                                                          .contraseaVisibility,
                                                                ),
                                                                focusNode: FocusNode(
                                                                    skipTraversal:
                                                                        true),
                                                                child: Icon(
                                                                  _model.contraseaVisibility
                                                                      ? Icons
                                                                          .visibility_outlined
                                                                      : Icons
                                                                          .visibility_off_outlined,
                                                                  color: GymHubTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 22,
                                                                ),
                                                              ),
                                                            ),
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
                                                                  fontSize:
                                                                      16.0,
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
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                            cursorColor:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .contraseaTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                        GHButtonWidget(
                                                          onPressed: () async {
                                                            if (_model.formKey
                                                                        .currentState ==
                                                                    null ||
                                                                !_model.formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                              return;
                                                            }
                                                            GoRouter.of(context)
                                                                .prepareAuthEvent();

                                                            final user =
                                                                await authManager
                                                                    .signInWithEmail(
                                                              context,
                                                              _model
                                                                  .emailTextController
                                                                  .text,
                                                              _model
                                                                  .contraseaTextController
                                                                  .text,
                                                            );
                                                            if (user == null) {
                                                              return;
                                                            }

                                                            GHAppState()
                                                                    .idUsuario =
                                                                currentUserUid;
                                                            GHAppState().email =
                                                                currentUserEmail;
                                                            safeSetState(() {});

                                                            context.goNamedAuth(
                                                                InicioWidget
                                                                    .routeName,
                                                                context
                                                                    .mounted);
                                                          },
                                                          text: 'Entrar',
                                                          options:
                                                              GHButtonOptions(
                                                            width: 150.0,
                                                            height: 45.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: GymHubTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                GymHubTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .interTight(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: GymHubTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: GymHubTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: GymHubTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            if (_model.emailTextController
                                                                        .text !=
                                                                    '') {
                                                              if (_model
                                                                  .emailTextController
                                                                  .text
                                                                  .isEmpty) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Email required!',
                                                                    ),
                                                                  ),
                                                                );
                                                                return;
                                                              }
                                                              await authManager
                                                                  .resetPassword(
                                                                email: _model
                                                                    .emailTextController
                                                                    .text,
                                                                context:
                                                                    context,
                                                                redirectTo:
                                                                    "gymhubapp://gymhubapp.com/resetContrasenna",
                                                              );
                                                            } else {
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Mensaje'),
                                                                    content: Text(
                                                                        'Ingresa un correo electrónico.'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                        child: Text(
                                                                            'Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            '¿Olvidaste tu contraseña? > Haz clic aquí <',
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
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 16.0)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
