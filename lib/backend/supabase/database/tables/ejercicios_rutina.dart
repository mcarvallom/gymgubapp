import '../database.dart';

class EjerciciosRutinaTable extends SupabaseTable<EjerciciosRutinaRow> {
  @override
  String get tableName => 'ejercicios_rutina';

  @override
  EjerciciosRutinaRow createRow(Map<String, dynamic> data) =>
      EjerciciosRutinaRow(data);
}

class EjerciciosRutinaRow extends SupabaseDataRow {
  EjerciciosRutinaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EjerciciosRutinaTable();

  int get ejercicioRutinaId => getField<int>('ejercicio_rutina_id')!;
  set ejercicioRutinaId(int value) =>
      setField<int>('ejercicio_rutina_id', value);

  int get rutinaId => getField<int>('rutina_id')!;
  set rutinaId(int value) => setField<int>('rutina_id', value);

  int? get ejercicioId => getField<int>('ejercicio_id');
  set ejercicioId(int? value) => setField<int>('ejercicio_id', value);

  String get nombreEjercicio => getField<String>('nombre_ejercicio')!;
  set nombreEjercicio(String value) =>
      setField<String>('nombre_ejercicio', value);

  int? get series => getField<int>('series');
  set series(int? value) => setField<int>('series', value);

  String? get repeticiones => getField<String>('repeticiones');
  set repeticiones(String? value) => setField<String>('repeticiones', value);

  int? get descansoSegundos => getField<int>('descanso_segundos');
  set descansoSegundos(int? value) => setField<int>('descanso_segundos', value);

  int? get ordenEjecucion => getField<int>('orden_ejecucion');
  set ordenEjecucion(int? value) => setField<int>('orden_ejecucion', value);

  String? get notas => getField<String>('notas');
  set notas(String? value) => setField<String>('notas', value);
}
