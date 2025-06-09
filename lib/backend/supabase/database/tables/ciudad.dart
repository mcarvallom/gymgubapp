import '../database.dart';

class CiudadTable extends SupabaseTable<CiudadRow> {
  @override
  String get tableName => 'ciudad';

  @override
  CiudadRow createRow(Map<String, dynamic> data) => CiudadRow(data);
}

class CiudadRow extends SupabaseDataRow {
  CiudadRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CiudadTable();

  int get idCiudad => getField<int>('id_ciudad')!;
  set idCiudad(int value) => setField<int>('id_ciudad', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);

  int get region => getField<int>('region')!;
  set region(int value) => setField<int>('region', value);
}
