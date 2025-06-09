import '../database.dart';

class AsistenciaTable extends SupabaseTable<AsistenciaRow> {
  @override
  String get tableName => 'asistencia';

  @override
  AsistenciaRow createRow(Map<String, dynamic> data) => AsistenciaRow(data);
}

class AsistenciaRow extends SupabaseDataRow {
  AsistenciaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AsistenciaTable();

  String get idAsistencia => getField<String>('id_asistencia')!;
  set idAsistencia(String value) => setField<String>('id_asistencia', value);

  String? get idUsuario => getField<String>('id_usuario');
  set idUsuario(String? value) => setField<String>('id_usuario', value);

  DateTime get horaIngreso => getField<DateTime>('hora_ingreso')!;
  set horaIngreso(DateTime value) => setField<DateTime>('hora_ingreso', value);
}
