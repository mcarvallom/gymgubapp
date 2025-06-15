import '../database.dart';

class ComidasTable extends SupabaseTable<ComidasRow> {
  @override
  String get tableName => 'comidas';

  @override
  ComidasRow createRow(Map<String, dynamic> data) => ComidasRow(data);
}

class ComidasRow extends SupabaseDataRow {
  ComidasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ComidasTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get dietaDiariaId => getField<int>('dieta_diaria_id')!;
  set dietaDiariaId(int value) => setField<int>('dieta_diaria_id', value);

  String? get tipoComida => getField<String>('tipo_comida');
  set tipoComida(String? value) => setField<String>('tipo_comida', value);

  String? get nombreComida => getField<String>('nombre_comida');
  set nombreComida(String? value) => setField<String>('nombre_comida', value);

  double? get totalCalorias => getField<double>('total_calorias');
  set totalCalorias(double? value) => setField<double>('total_calorias', value);

  String? get notas => getField<String>('notas');
  set notas(String? value) => setField<String>('notas', value);
}
