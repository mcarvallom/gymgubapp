import '../database.dart';

class RegionTable extends SupabaseTable<RegionRow> {
  @override
  String get tableName => 'region';

  @override
  RegionRow createRow(Map<String, dynamic> data) => RegionRow(data);
}

class RegionRow extends SupabaseDataRow {
  RegionRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RegionTable();

  int get idRegion => getField<int>('id_region')!;
  set idRegion(int value) => setField<int>('id_region', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);
}
