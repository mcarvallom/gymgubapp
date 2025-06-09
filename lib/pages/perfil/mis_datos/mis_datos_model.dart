import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '../../../gymhub/form_field_controller.dart';
import '../../../gymhub/request_manager.dart';

import 'mis_datos_widget.dart' show MisDatosWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MisDatosModel extends GymHubModel<MisDatosWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for nombre widget.
  FocusNode? nombreFocusNode;
  TextEditingController? nombreTextController;
  String? Function(BuildContext, String?)? nombreTextControllerValidator;
  // State field(s) for apellido widget.
  FocusNode? apellidoFocusNode;
  TextEditingController? apellidoTextController;
  String? Function(BuildContext, String?)? apellidoTextControllerValidator;
  // State field(s) for run widget.
  FocusNode? runFocusNode;
  TextEditingController? runTextController;
  final runMask = MaskTextInputFormatter(mask: '########');
  String? Function(BuildContext, String?)? runTextControllerValidator;
  // State field(s) for dv widget.
  FocusNode? dvFocusNode;
  TextEditingController? dvTextController;
  String? Function(BuildContext, String?)? dvTextControllerValidator;
  // State field(s) for numContacto widget.
  FocusNode? numContactoFocusNode;
  TextEditingController? numContactoTextController;
  final numContactoMask = MaskTextInputFormatter(mask: '#########');
  String? Function(BuildContext, String?)? numContactoTextControllerValidator;
  // State field(s) for numContactoEm widget.
  FocusNode? numContactoEmFocusNode;
  TextEditingController? numContactoEmTextController;
  final numContactoEmMask = MaskTextInputFormatter(mask: '#########');
  String? Function(BuildContext, String?)? numContactoEmTextControllerValidator;
  // State field(s) for direccion widget.
  FocusNode? direccionFocusNode;
  TextEditingController? direccionTextController;
  String? Function(BuildContext, String?)? direccionTextControllerValidator;
  // State field(s) for region widget.
  int? regionValue;
  FormFieldController<int>? regionValueController;
  // State field(s) for ciudad widget.
  int? ciudadValue;
  FormFieldController<int>? ciudadValueController;

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
    nombreFocusNode?.dispose();
    nombreTextController?.dispose();

    apellidoFocusNode?.dispose();
    apellidoTextController?.dispose();

    runFocusNode?.dispose();
    runTextController?.dispose();

    dvFocusNode?.dispose();
    dvTextController?.dispose();

    numContactoFocusNode?.dispose();
    numContactoTextController?.dispose();

    numContactoEmFocusNode?.dispose();
    numContactoEmTextController?.dispose();

    direccionFocusNode?.dispose();
    direccionTextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearUsuarioCache();
  }
}
