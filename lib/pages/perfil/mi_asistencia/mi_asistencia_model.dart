import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_calendar.dart';
import '/gymhub/gymhub_util.dart';
import '../../../gymhub/request_manager.dart';

import 'mi_asistencia_widget.dart' show MiAsistenciaWidget;
import 'package:flutter/material.dart';

class MiAsistenciaModel extends GymHubModel<MiAsistenciaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  /// Query cache managers for this widget.

  final _asistenciaManager = FutureRequestManager<List<AsistenciaRow>>();
  Future<List<AsistenciaRow>> asistencia({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<AsistenciaRow>> Function() requestFn,
  }) =>
      _asistenciaManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAsistenciaCache() => _asistenciaManager.clear();
  void clearAsistenciaCacheKey(String? uniqueKey) =>
      _asistenciaManager.clearRequest(uniqueKey);

  final _sucursalManager = FutureRequestManager<List<ContactoRow>>();
  Future<List<ContactoRow>> sucursal({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ContactoRow>> Function() requestFn,
  }) =>
      _sucursalManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearSucursalCache() => _sucursalManager.clear();
  void clearSucursalCacheKey(String? uniqueKey) =>
      _sucursalManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearAsistenciaCache();

    clearSucursalCache();
  }
}
