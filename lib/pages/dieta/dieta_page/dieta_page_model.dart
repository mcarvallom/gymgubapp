import '/gymhub/gymhub_calendar.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/botones_paginas_nav_bar/botones_paginas_nav_bar_widget.dart';
import '/index.dart';
import 'dieta_page_widget.dart' show DietaPageWidget;
import 'package:flutter/material.dart';

class DietaPageModel extends GymHubModel<DietaPageWidget> {
  late BotonesPaginasNavBarModel botonesPaginasNavBarModel;
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
