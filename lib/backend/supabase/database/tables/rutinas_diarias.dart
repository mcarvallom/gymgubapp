import '../database.dart';

class RutinasDiariasTable extends SupabaseTable<RutinasDiariasRow> {
  @override
  String get tableName => 'rutinas_diarias';

  @override
  RutinasDiariasRow createRow(Map<String, dynamic> data) =>
      RutinasDiariasRow(data);
}

class RutinasDiariasRow extends SupabaseDataRow {
  RutinasDiariasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RutinasDiariasTable();

  int get rutinaId => getField<int>('rutina_id')!;
  set rutinaId(int value) => setField<int>('rutina_id', value);

  int get planId => getField<int>('plan_id')!;
  set planId(int value) => setField<int>('plan_id', value);

  String? get diaSemana => getField<String>('dia_semana');
  set diaSemana(String? value) => setField<String>('dia_semana', value);

  String? get enfoque => getField<String>('enfoque');
  set enfoque(String? value) => setField<String>('enfoque', value);

  bool? get descanso => getField<bool>('descanso');
  set descanso(bool? value) => setField<bool>('descanso', value);
}
