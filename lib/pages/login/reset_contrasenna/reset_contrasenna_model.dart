import '/gymhub/gymhub_util.dart';
import '/index.dart';
import 'reset_contrasenna_widget.dart' show ResetContrasennaWidget;
import 'package:flutter/material.dart';

class ResetContrasennaModel extends GymHubModel<ResetContrasennaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Contrasea widget.
  FocusNode? contraseaFocusNode;
  TextEditingController? contraseaTextController;
  late bool contraseaVisibility;
  String? Function(BuildContext, String?)? contraseaTextControllerValidator;
  // State field(s) for ConfirmContrasea widget.
  FocusNode? confirmContraseaFocusNode;
  TextEditingController? confirmContraseaTextController;
  late bool confirmContraseaVisibility;
  String? Function(BuildContext, String?)?
      confirmContraseaTextControllerValidator;

  @override
  void initState(BuildContext context) {
    contraseaVisibility = false;
    confirmContraseaVisibility = false;
  }

  @override
  void dispose() {
    contraseaFocusNode?.dispose();
    contraseaTextController?.dispose();

    confirmContraseaFocusNode?.dispose();
    confirmContraseaTextController?.dispose();
  }
}
