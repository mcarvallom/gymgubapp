import '/gymhub/gymhub_calendar.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/botones_paginas_nav_bar/botones_paginas_nav_bar_widget.dart';
import '/index.dart';
import 'dieta_page_widget.dart' show DietaPageWidget;
import 'package:flutter/material.dart';

class DietaPageModel extends GymHubModel<DietaPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for botonesPaginasNavBar component.
  late BotonesPaginasNavBarModel botonesPaginasNavBarModel;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  @override
  void initState(BuildContext context) {
    botonesPaginasNavBarModel =
        createModel(context, () => BotonesPaginasNavBarModel());
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    botonesPaginasNavBarModel.dispose();
  }
}
