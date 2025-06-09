import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ingreso_q_r_model.dart';
export 'ingreso_q_r_model.dart';

class IngresoQRWidget extends StatefulWidget {
  const IngresoQRWidget({super.key});

  static String routeName = 'ingresoQR';
  static String routePath = '/ingresoQR';

  @override
  State<IngresoQRWidget> createState() => _IngresoQRWidgetState();
}

class _IngresoQRWidgetState extends State<IngresoQRWidget> {
  late IngresoQRModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IngresoQRModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UsuarioRow>>(
      future: UsuarioTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id_usuario',
          currentUserUid,
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
        List<UsuarioRow> ingresoQRUsuarioRowList = snapshot.data!;

        final ingresoQRUsuarioRow = ingresoQRUsuarioRowList.isNotEmpty
            ? ingresoQRUsuarioRowList.first
            : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: GymHubTheme.of(context).primaryBackground,
            body: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BarcodeWidget(
                        data:
                            '${currentUserUid}${ingresoQRUsuarioRow?.nombre}${ingresoQRUsuarioRow?.apellido}${dateTimeFormat(
                          "d/M/y",
                          getCurrentTimestamp,
                          locale: FFLocalizations.of(context).languageCode,
                        )}${dateTimeFormat(
                          "Hm",
                          getCurrentTimestamp,
                          locale: FFLocalizations.of(context).languageCode,
                        )}',
                        barcode: Barcode.qrCode(),
                        width: 200.0,
                        height: 200.0,
                        color: GymHubTheme.of(context).primaryText,
                        backgroundColor: Colors.transparent,
                        errorBuilder: (_context, _error) => SizedBox(
                          width: 200.0,
                          height: 200.0,
                        ),
                        drawText: false,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Muestra tu QR para hacer ingreso al recinto',
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
                                    fontSize: 16.0,
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
                        ].divide(SizedBox(width: 6.0)),
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
