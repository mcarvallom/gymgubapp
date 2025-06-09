import '../database.dart';

class PlanGimnasioTable extends SupabaseTable<PlanGimnasioRow> {
  @override
  String get tableName => 'plan_gimnasio';

  @override
  PlanGimnasioRow createRow(Map<String, dynamic> data) => PlanGimnasioRow(data);
}

class PlanGimnasioRow extends SupabaseDataRow {
  PlanGimnasioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlanGimnasioTable();

  String get idPlan => getField<String>('id_plan')!;
  set idPlan(String value) => setField<String>('id_plan', value);

  String get nombrePlan => getField<String>('nombre_plan')!;
  set nombrePlan(String value) => setField<String>('nombre_plan', value);

  String? get descripcion => getField<String>('descripcion');
  set descripcion(String? value) => setField<String>('descripcion', value);

  int get precio => getField<int>('precio')!;
  set precio(int value) => setField<int>('precio', value);

  int get duracion => getField<int>('duracion')!;
  set duracion(int value) => setField<int>('duracion', value);

  String get estado => getField<String>('estado')!;
  set estado(String value) => setField<String>('estado', value);
}
