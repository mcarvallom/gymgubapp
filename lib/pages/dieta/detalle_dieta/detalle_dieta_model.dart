import '/gymhub/gymhub_util.dart';
import '/pages/botones_paginas_nav_bar/botones_paginas_nav_bar_widget.dart';
import 'detalle_dieta_widget.dart' show DetalleDietaWidget;
import 'package:flutter/material.dart';

class DetalleDietaModel extends GymHubModel<DetalleDietaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for botonesPaginasNavBar component.
  late BotonesPaginasNavBarModel botonesPaginasNavBarModel;

  @override
  void initState(BuildContext context) {
    botonesPaginasNavBarModel =
        createModel(context, () => BotonesPaginasNavBarModel());
  }

  @override
  void dispose() {
    botonesPaginasNavBarModel.dispose();
  }
}
