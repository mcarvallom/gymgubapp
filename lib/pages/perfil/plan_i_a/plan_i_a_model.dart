import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '../../../gymhub/form_field_controller.dart';
import '../../../gymhub/request_manager.dart';

import 'plan_i_a_widget.dart' show PlanIAWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PlanIAModel extends GymHubModel<PlanIAWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for peso widget.
  FocusNode? pesoFocusNode;
  TextEditingController? pesoTextController;
  final pesoMask = MaskTextInputFormatter(mask: '####');
  String? Function(BuildContext, String?)? pesoTextControllerValidator;
  // State field(s) for estatura widget.
  FocusNode? estaturaFocusNode;
  TextEditingController? estaturaTextController;
  String? Function(BuildContext, String?)? estaturaTextControllerValidator;
  // State field(s) for pesoideal widget.
  FocusNode? pesoidealFocusNode;
  TextEditingController? pesoidealTextController;
  final pesoidealMask = MaskTextInputFormatter(mask: '####');
  String? Function(BuildContext, String?)? pesoidealTextControllerValidator;
  // State field(s) for restriccionAlimentaria widget.
  FocusNode? restriccionAlimentariaFocusNode;
  TextEditingController? restriccionAlimentariaTextController;
  String? Function(BuildContext, String?)?
      restriccionAlimentariaTextControllerValidator;
  // State field(s) for restriccionFisica widget.
  FocusNode? restriccionFisicaFocusNode;
  TextEditingController? restriccionFisicaTextController;
  String? Function(BuildContext, String?)?
      restriccionFisicaTextControllerValidator;
  // State field(s) for objetivodieta widget.
  String? objetivodietaValue;
  FormFieldController<String>? objetivodietaValueController;
  // State field(s) for objetivoEjercicio widget.
  String? objetivoEjercicioValue;
  FormFieldController<String>? objetivoEjercicioValueController;

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

  final _generoManager = FutureRequestManager<List<GeneroRow>>();
  Future<List<GeneroRow>> genero({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<GeneroRow>> Function() requestFn,
  }) =>
      _generoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGeneroCache() => _generoManager.clear();
  void clearGeneroCacheKey(String? uniqueKey) =>
      _generoManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    pesoFocusNode?.dispose();
    pesoTextController?.dispose();

    estaturaFocusNode?.dispose();
    estaturaTextController?.dispose();

    pesoidealFocusNode?.dispose();
    pesoidealTextController?.dispose();

    restriccionAlimentariaFocusNode?.dispose();
    restriccionAlimentariaTextController?.dispose();

    restriccionFisicaFocusNode?.dispose();
    restriccionFisicaTextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearUsuarioCache();

    clearGeneroCache();
  }
}
