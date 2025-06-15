import '../database.dart';

class VCantidadPlanTable extends SupabaseTable<VCantidadPlanRow> {
  @override
  String get tableName => 'v_cantidad_plan';

  @override
  VCantidadPlanRow createRow(Map<String, dynamic> data) =>
      VCantidadPlanRow(data);
}

class VCantidadPlanRow extends SupabaseDataRow {
  VCantidadPlanRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VCantidadPlanTable();

  String? get idPlan => getField<String>('id_plan');
  set idPlan(String? value) => setField<String>('id_plan', value);

  int? get cantidadPlan => getField<int>('cantidad_plan');
  set cantidadPlan(int? value) => setField<int>('cantidad_plan', value);
}
