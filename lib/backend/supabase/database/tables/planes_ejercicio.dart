import '../database.dart';

class PlanesEjercicioTable extends SupabaseTable<PlanesEjercicioRow> {
  @override
  String get tableName => 'planes_ejercicio';

  @override
  PlanesEjercicioRow createRow(Map<String, dynamic> data) =>
      PlanesEjercicioRow(data);
}

class PlanesEjercicioRow extends SupabaseDataRow {
  PlanesEjercicioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PlanesEjercicioTable();

  int get planId => getField<int>('plan_id')!;
  set planId(int value) => setField<int>('plan_id', value);

  String get usuarioId => getField<String>('usuario_id')!;
  set usuarioId(String value) => setField<String>('usuario_id', value);

  DateTime? get fechaCreacion => getField<DateTime>('fecha_creacion');
  set fechaCreacion(DateTime? value) =>
      setField<DateTime>('fecha_creacion', value);

  String get objetivo => getField<String>('objetivo')!;
  set objetivo(String value) => setField<String>('objetivo', value);

  String get nivelUsuario => getField<String>('nivel_usuario')!;
  set nivelUsuario(String value) => setField<String>('nivel_usuario', value);

  int? get diasSemana => getField<int>('dias_semana');
  set diasSemana(int? value) => setField<int>('dias_semana', value);

  int? get duracionSesionMin => getField<int>('duracion_sesion_min');
  set duracionSesionMin(int? value) =>
      setField<int>('duracion_sesion_min', value);

  String? get notas => getField<String>('notas');
  set notas(String? value) => setField<String>('notas', value);
}
