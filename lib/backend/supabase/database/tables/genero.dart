import '../database.dart';

class GeneroTable extends SupabaseTable<GeneroRow> {
  @override
  String get tableName => 'genero';

  @override
  GeneroRow createRow(Map<String, dynamic> data) => GeneroRow(data);
}

class GeneroRow extends SupabaseDataRow {
  GeneroRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GeneroTable();

  int get idGenero => getField<int>('id_genero')!;
  set idGenero(int value) => setField<int>('id_genero', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get nombre => getField<String>('nombre');
  set nombre(String? value) => setField<String>('nombre', value);
}
