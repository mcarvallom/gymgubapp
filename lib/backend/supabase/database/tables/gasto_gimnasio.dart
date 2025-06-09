import '../database.dart';

class GastoGimnasioTable extends SupabaseTable<GastoGimnasioRow> {
  @override
  String get tableName => 'gasto_gimnasio';

  @override
  GastoGimnasioRow createRow(Map<String, dynamic> data) =>
      GastoGimnasioRow(data);
}

class GastoGimnasioRow extends SupabaseDataRow {
  GastoGimnasioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GastoGimnasioTable();

  String get idGasto => getField<String>('id_gasto')!;
  set idGasto(String value) => setField<String>('id_gasto', value);

  String get descripcion => getField<String>('descripcion')!;
  set descripcion(String value) => setField<String>('descripcion', value);

  int get monto => getField<int>('monto')!;
  set monto(int value) => setField<int>('monto', value);

  DateTime get fecha => getField<DateTime>('fecha')!;
  set fecha(DateTime value) => setField<DateTime>('fecha', value);

  String get categoriaGasto => getField<String>('categoria_gasto')!;
  set categoriaGasto(String value) =>
      setField<String>('categoria_gasto', value);
}
