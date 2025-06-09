import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/formulario_tarjeta/formulario_tarjeta_widget.dart';
import 'package:flutter/material.dart';

Future membresia(BuildContext context) async {
  List<MembresiaRow>? membresia;

  membresia = await MembresiaTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'id_usuario',
      currentUserUid,
    ),
  );
  FFAppState().estado = membresia.firstOrNull!.estado;
  if (FFAppState().estado != '047930a7-0dd1-4885-92da-7a849d353e9a') {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment: AlignmentDirectional(0.0, 0.0)
              .resolve(Directionality.of(context)),
          child: FormularioTarjetaWidget(),
        );
      },
    );
  }
}
