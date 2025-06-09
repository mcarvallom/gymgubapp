import '../database.dart';

class DietaDiariaTable extends SupabaseTable<DietaDiariaRow> {
  @override
  String get tableName => 'dieta_diaria';

  @override
  DietaDiariaRow createRow(Map<String, dynamic> data) => DietaDiariaRow(data);
}

class DietaDiariaRow extends SupabaseDataRow {
  DietaDiariaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DietaDiariaTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get dietaId => getField<int>('dieta_id');
  set dietaId(int? value) => setField<int>('dieta_id', value);

  String? get diaSemana => getField<String>('dia_semana');
  set diaSemana(String? value) => setField<String>('dia_semana', value);

  String? get enfoque => getField<String>('enfoque');
  set enfoque(String? value) => setField<String>('enfoque', value);

  String? get titulo => getField<String>('titulo');
  set titulo(String? value) => setField<String>('titulo', value);
}
