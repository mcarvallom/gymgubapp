import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '../../../gymhub/request_manager.dart';

import 'membresia_widget.dart' show MembresiaWidget;
import 'package:flutter/material.dart';

class MembresiaModel extends GymHubModel<MembresiaWidget> {
  /// Query cache managers for this widget.

  final _membresiaManager = FutureRequestManager<List<MembresiaRow>>();
  Future<List<MembresiaRow>> membresia({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<MembresiaRow>> Function() requestFn,
  }) =>
      _membresiaManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMembresiaCache() => _membresiaManager.clear();
  void clearMembresiaCacheKey(String? uniqueKey) =>
      _membresiaManager.clearRequest(uniqueKey);

  final _planGymManager = FutureRequestManager<List<PlanGimnasioRow>>();
  Future<List<PlanGimnasioRow>> planGym({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<PlanGimnasioRow>> Function() requestFn,
  }) =>
      _planGymManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPlanGymCache() => _planGymManager.clear();
  void clearPlanGymCacheKey(String? uniqueKey) =>
      _planGymManager.clearRequest(uniqueKey);

  final _estadoManager = FutureRequestManager<List<EstadoRow>>();
  Future<List<EstadoRow>> estado({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<EstadoRow>> Function() requestFn,
  }) =>
      _estadoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEstadoCache() => _estadoManager.clear();
  void clearEstadoCacheKey(String? uniqueKey) =>
      _estadoManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearMembresiaCache();

    clearPlanGymCache();

    clearEstadoCache();
  }
}
