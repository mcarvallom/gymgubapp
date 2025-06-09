import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_calendar.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/botones_paginas_nav_bar/botones_paginas_nav_bar_widget.dart';
import '../../../gymhub/request_manager.dart';

import 'ejercicios_page_widget.dart' show EjerciciosPageWidget;
import 'package:flutter/material.dart';

class EjerciciosPageModel extends GymHubModel<EjerciciosPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for botonesPaginasNavBar component.
  late BotonesPaginasNavBarModel botonesPaginasNavBarModel;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  /// Query cache managers for this widget.

  final _ejercicioManager = FutureRequestManager<List<EjerciciosRow>>();
  Future<List<EjerciciosRow>> ejercicio({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<EjerciciosRow>> Function() requestFn,
  }) =>
      _ejercicioManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEjercicioCache() => _ejercicioManager.clear();
  void clearEjercicioCacheKey(String? uniqueKey) =>
      _ejercicioManager.clearRequest(uniqueKey);

  final _planEjercicioManager =
      FutureRequestManager<List<PlanesEjercicioRow>>();
  Future<List<PlanesEjercicioRow>> planEjercicio({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<PlanesEjercicioRow>> Function() requestFn,
  }) =>
      _planEjercicioManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPlanEjercicioCache() => _planEjercicioManager.clear();
  void clearPlanEjercicioCacheKey(String? uniqueKey) =>
      _planEjercicioManager.clearRequest(uniqueKey);

  final _rutinaDiariaManager = FutureRequestManager<List<RutinasDiariasRow>>();
  Future<List<RutinasDiariasRow>> rutinaDiaria({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<RutinasDiariasRow>> Function() requestFn,
  }) =>
      _rutinaDiariaManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRutinaDiariaCache() => _rutinaDiariaManager.clear();
  void clearRutinaDiariaCacheKey(String? uniqueKey) =>
      _rutinaDiariaManager.clearRequest(uniqueKey);

  final _ejercicioRutinaManager =
      FutureRequestManager<List<EjerciciosRutinaRow>>();
  Future<List<EjerciciosRutinaRow>> ejercicioRutina({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<EjerciciosRutinaRow>> Function() requestFn,
  }) =>
      _ejercicioRutinaManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEjercicioRutinaCache() => _ejercicioRutinaManager.clear();
  void clearEjercicioRutinaCacheKey(String? uniqueKey) =>
      _ejercicioRutinaManager.clearRequest(uniqueKey);

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

    /// Dispose query cache managers for this widget.

    clearEjercicioCache();

    clearPlanEjercicioCache();

    clearRutinaDiariaCache();

    clearEjercicioRutinaCache();
  }
}
