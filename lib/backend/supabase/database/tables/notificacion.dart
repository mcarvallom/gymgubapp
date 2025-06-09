import '../database.dart';

class NotificacionTable extends SupabaseTable<NotificacionRow> {
  @override
  String get tableName => 'notificacion';

  @override
  NotificacionRow createRow(Map<String, dynamic> data) => NotificacionRow(data);
}

class NotificacionRow extends SupabaseDataRow {
  NotificacionRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => NotificacionTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get fechaNoti => getField<DateTime>('fecha_noti')!;
  set fechaNoti(DateTime value) => setField<DateTime>('fecha_noti', value);

  String? get descripcion => getField<String>('descripcion');
  set descripcion(String? value) => setField<String>('descripcion', value);
}
