import '../database.dart';

class CategoriaGastoTable extends SupabaseTable<CategoriaGastoRow> {
  @override
  String get tableName => 'categoria_gasto';

  @override
  CategoriaGastoRow createRow(Map<String, dynamic> data) =>
      CategoriaGastoRow(data);
}

class CategoriaGastoRow extends SupabaseDataRow {
  CategoriaGastoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CategoriaGastoTable();

  String get idCategoriaGasto => getField<String>('id_categoria_gasto')!;
  set idCategoriaGasto(String value) =>
      setField<String>('id_categoria_gasto', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);
}
