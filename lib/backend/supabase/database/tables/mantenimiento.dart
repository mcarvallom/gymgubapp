import '../database.dart';

class MantenimientoTable extends SupabaseTable<MantenimientoRow> {
  @override
  String get tableName => 'mantenimiento';

  @override
  MantenimientoRow createRow(Map<String, dynamic> data) =>
      MantenimientoRow(data);
}

class MantenimientoRow extends SupabaseDataRow {
  MantenimientoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MantenimientoTable();

  String? get idEquipo => getField<String>('id_equipo');
  set idEquipo(String? value) => setField<String>('id_equipo', value);

  DateTime get fechaMantenimiento => getField<DateTime>('fecha_mantenimiento')!;
  set fechaMantenimiento(DateTime value) =>
      setField<DateTime>('fecha_mantenimiento', value);

  String? get descripcion => getField<String>('descripcion');
  set descripcion(String? value) => setField<String>('descripcion', value);

  int get costo => getField<int>('costo')!;
  set costo(int value) => setField<int>('costo', value);

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get idTipoMant => getField<int>('id_tipo_mant');
  set idTipoMant(int? value) => setField<int>('id_tipo_mant', value);
}
