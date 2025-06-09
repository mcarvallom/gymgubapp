import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/home/sinejercicios/sinejercicios_widget.dart';
import 'dart:async';
import '../../../gymhub/request_manager.dart';

import '/index.dart';
import 'inicio_widget.dart' show InicioWidget;
import 'package:flutter/material.dart';

class InicioModel extends GymHubModel<InicioWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for sinejercicios component.
  late SinejerciciosModel sinejerciciosModel;

  /// Query cache managers for this widget.

  final _usuarioManager = FutureRequestManager<List<UsuarioRow>>();
  Future<List<UsuarioRow>> usuario({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsuarioRow>> Function() requestFn,
  }) =>
      _usuarioManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUsuarioCache() => _usuarioManager.clear();
  void clearUsuarioCacheKey(String? uniqueKey) =>
      _usuarioManager.clearRequest(uniqueKey);

  final _dietasalmuerzoManager = FutureRequestManager<List<DietaRow>>();
  Future<List<DietaRow>> dietasalmuerzo({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<DietaRow>> Function() requestFn,
  }) =>
      _dietasalmuerzoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDietasalmuerzoCache() => _dietasalmuerzoManager.clear();
  void clearDietasalmuerzoCacheKey(String? uniqueKey) =>
      _dietasalmuerzoManager.clearRequest(uniqueKey);

  final _dietasdesayunoManager = FutureRequestManager<List<DietaRow>>();
  Future<List<DietaRow>> dietasdesayuno({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<DietaRow>> Function() requestFn,
  }) =>
      _dietasdesayunoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDietasdesayunoCache() => _dietasdesayunoManager.clear();
  void clearDietasdesayunoCacheKey(String? uniqueKey) =>
      _dietasdesayunoManager.clearRequest(uniqueKey);

  final _dietasdiariasCenaManager =
      FutureRequestManager<List<DietaDiariaRow>>();
  Future<List<DietaDiariaRow>> dietasdiariasCena({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<DietaDiariaRow>> Function() requestFn,
  }) =>
      _dietasdiariasCenaManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDietasdiariasCenaCache() => _dietasdiariasCenaManager.clear();
  void clearDietasdiariasCenaCacheKey(String? uniqueKey) =>
      _dietasdiariasCenaManager.clearRequest(uniqueKey);

  final _dietasdiariasManager = FutureRequestManager<List<DietaDiariaRow>>();
  Future<List<DietaDiariaRow>> dietasdiarias({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<DietaDiariaRow>> Function() requestFn,
  }) =>
      _dietasdiariasManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDietasdiariasCache() => _dietasdiariasManager.clear();
  void clearDietasdiariasCacheKey(String? uniqueKey) =>
      _dietasdiariasManager.clearRequest(uniqueKey);

  final _dietasCenaManager = FutureRequestManager<List<DietaRow>>();
  Future<List<DietaRow>> dietasCena({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<DietaRow>> Function() requestFn,
  }) =>
      _dietasCenaManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDietasCenaCache() => _dietasCenaManager.clear();
  void clearDietasCenaCacheKey(String? uniqueKey) =>
      _dietasCenaManager.clearRequest(uniqueKey);

  final _dietasdiariasAlmuerzoManager =
      FutureRequestManager<List<DietaDiariaRow>>();
  Future<List<DietaDiariaRow>> dietasdiariasAlmuerzo({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<DietaDiariaRow>> Function() requestFn,
  }) =>
      _dietasdiariasAlmuerzoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDietasdiariasAlmuerzoCache() =>
      _dietasdiariasAlmuerzoManager.clear();
  void clearDietasdiariasAlmuerzoCacheKey(String? uniqueKey) =>
      _dietasdiariasAlmuerzoManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    sinejerciciosModel = createModel(context, () => SinejerciciosModel());
  }

  @override
  void dispose() {
    sinejerciciosModel.dispose();

    /// Dispose query cache managers for this widget.

    clearUsuarioCache();

    clearDietasalmuerzoCache();

    clearDietasdesayunoCache();

    clearDietasdiariasCenaCache();

    clearDietasdiariasCache();

    clearDietasCenaCache();

    clearDietasdiariasAlmuerzoCache();
  }
}
