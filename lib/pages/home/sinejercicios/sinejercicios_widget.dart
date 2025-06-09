import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sinejercicios_model.dart';
export 'sinejercicios_model.dart';

class SinejerciciosWidget extends StatefulWidget {
  const SinejerciciosWidget({super.key});

  @override
  State<SinejerciciosWidget> createState() => _SinejerciciosWidgetState();
}

class _SinejerciciosWidgetState extends State<SinejerciciosWidget> {
  late SinejerciciosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SinejerciciosModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Sin ejercicios el día de hoy, debes recuperar energías...',
        textAlign: TextAlign.center,
        style: GymHubTheme.of(context).bodyMedium.override(
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
  }
}
