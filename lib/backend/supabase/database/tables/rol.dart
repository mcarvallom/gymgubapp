import '../database.dart';

class RolTable extends SupabaseTable<RolRow> {
  @override
  String get tableName => 'rol';

  @override
  RolRow createRow(Map<String, dynamic> data) => RolRow(data);
}

class RolRow extends SupabaseDataRow {
  RolRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RolTable();

  String get idRol => getField<String>('id_rol')!;
  set idRol(String value) => setField<String>('id_rol', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);
}
