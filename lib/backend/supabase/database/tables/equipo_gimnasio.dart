import '../database.dart';

class EquipoGimnasioTable extends SupabaseTable<EquipoGimnasioRow> {
  @override
  String get tableName => 'equipo_gimnasio';

  @override
  EquipoGimnasioRow createRow(Map<String, dynamic> data) =>
      EquipoGimnasioRow(data);
}

class EquipoGimnasioRow extends SupabaseDataRow {
  EquipoGimnasioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EquipoGimnasioTable();

  String get idEquipo => getField<String>('id_equipo')!;
  set idEquipo(String value) => setField<String>('id_equipo', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);

  String? get descripcion => getField<String>('descripcion');
  set descripcion(String? value) => setField<String>('descripcion', value);

  DateTime? get fechaAdquisicion => getField<DateTime>('fecha_adquisicion');
  set fechaAdquisicion(DateTime? value) =>
      setField<DateTime>('fecha_adquisicion', value);

  String? get estado => getField<String>('estado');
  set estado(String? value) => setField<String>('estado', value);
}
