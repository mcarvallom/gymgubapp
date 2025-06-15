import '../database.dart';

class ComidaIngredientesTable extends SupabaseTable<ComidaIngredientesRow> {
  @override
  String get tableName => 'comida_ingredientes';

  @override
  ComidaIngredientesRow createRow(Map<String, dynamic> data) =>
      ComidaIngredientesRow(data);
}

class ComidaIngredientesRow extends SupabaseDataRow {
  ComidaIngredientesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ComidaIngredientesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get dietaDiaria => getField<int>('dieta_diaria');
  set dietaDiaria(int? value) => setField<int>('dieta_diaria', value);

  int? get ingredienteId => getField<int>('ingrediente_id');
  set ingredienteId(int? value) => setField<int>('ingrediente_id', value);

  String? get nombreIngrediente => getField<String>('nombre_ingrediente');
  set nombreIngrediente(String? value) =>
      setField<String>('nombre_ingrediente', value);

  String? get calorias => getField<String>('calorias');
  set calorias(String? value) => setField<String>('calorias', value);

  String? get grasa => getField<String>('grasa');
  set grasa(String? value) => setField<String>('grasa', value);

  String? get carbohidratos => getField<String>('carbohidratos');
  set carbohidratos(String? value) => setField<String>('carbohidratos', value);

  String? get proteina => getField<String>('proteina');
  set proteina(String? value) => setField<String>('proteina', value);

  String? get azucar => getField<String>('azucar');
  set azucar(String? value) => setField<String>('azucar', value);

  String? get cantidad => getField<String>('cantidad');
  set cantidad(String? value) => setField<String>('cantidad', value);
}
