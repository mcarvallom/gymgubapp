import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sindieta_model.dart';
export 'sindieta_model.dart';

class SindietaWidget extends StatefulWidget {
  const SindietaWidget({super.key});

  @override
  State<SindietaWidget> createState() => _SindietaWidgetState();
}

class _SindietaWidgetState extends State<SindietaWidget> {
  late SindietaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SindietaModel());
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
        'Sin dieta para el día de hoy...',
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
