import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_util.dart';
import '/index.dart';
import 'pagina_espera_widget.dart' show PaginaEsperaWidget;
import 'package:flutter/material.dart';

class PaginaEsperaModel extends GymHubModel<PaginaEsperaWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in paginaEspera widget.
  List<MembresiaRow>? membresia;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
