import '/gymhub/gymhub_util.dart';
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

class LoginModel extends GymHubModel<LoginWidget> {

  final formKey = GlobalKey<FormState>();
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'El correo es obligatorio';
    }

    return null;
  }

  FocusNode? contraseaFocusNode;
  TextEditingController? contraseaTextController;
  late bool contraseaVisibility;
  String? Function(BuildContext, String?)? contraseaTextControllerValidator;
  String? _contraseaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'La contraseña es obligatoria';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    emailTextControllerValidator = _emailTextControllerValidator;
    contraseaVisibility = false;
    contraseaTextControllerValidator = _contraseaTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    contraseaFocusNode?.dispose();
    contraseaTextController?.dispose();
  }
}
