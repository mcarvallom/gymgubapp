import '../database.dart';

class TipoMantenimientoTable extends SupabaseTable<TipoMantenimientoRow> {
  @override
  String get tableName => 'tipo_mantenimiento';

  @override
  TipoMantenimientoRow createRow(Map<String, dynamic> data) =>
      TipoMantenimientoRow(data);
}

class TipoMantenimientoRow extends SupabaseDataRow {
  TipoMantenimientoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TipoMantenimientoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get nombre => getField<String>('nombre');
  set nombre(String? value) => setField<String>('nombre', value);
}
