import '../database.dart';

class MembresiaTable extends SupabaseTable<MembresiaRow> {
  @override
  String get tableName => 'membresia';

  @override
  MembresiaRow createRow(Map<String, dynamic> data) => MembresiaRow(data);
}

class MembresiaRow extends SupabaseDataRow {
  MembresiaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MembresiaTable();

  DateTime? get fechaInicio => getField<DateTime>('fecha_inicio');
  set fechaInicio(DateTime? value) => setField<DateTime>('fecha_inicio', value);

  DateTime? get fechaFin => getField<DateTime>('fecha_fin');
  set fechaFin(DateTime? value) => setField<DateTime>('fecha_fin', value);

  String get idPlan => getField<String>('id_plan')!;
  set idPlan(String value) => setField<String>('id_plan', value);

  String get estado => getField<String>('estado')!;
  set estado(String value) => setField<String>('estado', value);

  String get idUsuario => getField<String>('id_usuario')!;
  set idUsuario(String value) => setField<String>('id_usuario', value);

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);
}
