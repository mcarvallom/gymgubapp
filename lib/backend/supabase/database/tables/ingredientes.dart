import '../database.dart';

class IngredientesTable extends SupabaseTable<IngredientesRow> {
  @override
  String get tableName => 'ingredientes';

  @override
  IngredientesRow createRow(Map<String, dynamic> data) => IngredientesRow(data);
}

class IngredientesRow extends SupabaseDataRow {
  IngredientesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => IngredientesTable();

  int get ingredienteId => getField<int>('ingrediente_id')!;
  set ingredienteId(int value) => setField<int>('ingrediente_id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get nombre => getField<String>('nombre');
  set nombre(String? value) => setField<String>('nombre', value);
}
