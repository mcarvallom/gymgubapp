import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '../../gymhub/request_manager.dart';

import 'formulario_tarjeta_widget.dart' show FormularioTarjetaWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormularioTarjetaModel extends GymHubModel<FormularioTarjetaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for numTarjeta widget.
  FocusNode? numTarjetaFocusNode1;
  TextEditingController? numTarjetaTextController1;
  final numTarjetaMask1 = MaskTextInputFormatter(mask: '#### #### #### ####');
  String? Function(BuildContext, String?)? numTarjetaTextController1Validator;
  // State field(s) for mesTarjeta widget.
  FocusNode? mesTarjetaFocusNode;
  TextEditingController? mesTarjetaTextController;
  final mesTarjetaMask = MaskTextInputFormatter(mask: '##');
  String? Function(BuildContext, String?)? mesTarjetaTextControllerValidator;
  // State field(s) for annioTarjeta widget.
  FocusNode? annioTarjetaFocusNode;
  TextEditingController? annioTarjetaTextController;
  final annioTarjetaMask = MaskTextInputFormatter(mask: '##');
  String? Function(BuildContext, String?)? annioTarjetaTextControllerValidator;
  // State field(s) for cvvTarjeta widget.
  FocusNode? cvvTarjetaFocusNode;
  TextEditingController? cvvTarjetaTextController;
  late bool cvvTarjetaVisibility;
  final cvvTarjetaMask = MaskTextInputFormatter(mask: '###');
  String? Function(BuildContext, String?)? cvvTarjetaTextControllerValidator;
  // State field(s) for numTarjeta widget.
  FocusNode? numTarjetaFocusNode2;
  TextEditingController? numTarjetaTextController2;
  String? Function(BuildContext, String?)? numTarjetaTextController2Validator;
  // State field(s) for run widget.
  FocusNode? runFocusNode;
  TextEditingController? runTextController;
  final runMask = MaskTextInputFormatter(mask: '########');
  String? Function(BuildContext, String?)? runTextControllerValidator;
  // State field(s) for dv widget.
  FocusNode? dvFocusNode;
  TextEditingController? dvTextController;
  String? Function(BuildContext, String?)? dvTextControllerValidator;
  // Stores action output result for [Backend Call - API (crear token)] action in Button widget.
  ApiCallResponse? generarTokenTarjeta;
  // Stores action output result for [Backend Call - API (procesar pago)] action in Button widget.
  ApiCallResponse? crearPago;

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

  final _planManager = FutureRequestManager<List<PlanGimnasioRow>>();
  Future<List<PlanGimnasioRow>> plan({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<PlanGimnasioRow>> Function() requestFn,
  }) =>
      _planManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPlanCache() => _planManager.clear();
  void clearPlanCacheKey(String? uniqueKey) =>
      _planManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    cvvTarjetaVisibility = false;
  }

  @override
  void dispose() {
    numTarjetaFocusNode1?.dispose();
    numTarjetaTextController1?.dispose();

    mesTarjetaFocusNode?.dispose();
    mesTarjetaTextController?.dispose();

    annioTarjetaFocusNode?.dispose();
    annioTarjetaTextController?.dispose();

    cvvTarjetaFocusNode?.dispose();
    cvvTarjetaTextController?.dispose();

    numTarjetaFocusNode2?.dispose();
    numTarjetaTextController2?.dispose();

    runFocusNode?.dispose();
    runTextController?.dispose();

    dvFocusNode?.dispose();
    dvTextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearMembresiaCache();

    clearPlanCache();
  }
}
