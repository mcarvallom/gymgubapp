import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '../../../gymhub/request_manager.dart';

import '/index.dart';
import 'perfil_widget.dart' show PerfilWidget;
import 'package:flutter/material.dart';

class PerfilModel extends GymHubModel<PerfilWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearUsuarioCache();
  }
}
