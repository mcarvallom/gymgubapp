import '../database.dart';

class EstadoTable extends SupabaseTable<EstadoRow> {
  @override
  String get tableName => 'estado';

  @override
  EstadoRow createRow(Map<String, dynamic> data) => EstadoRow(data);
}

class EstadoRow extends SupabaseDataRow {
  EstadoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EstadoTable();

  String get idEstado => getField<String>('id_estado')!;
  set idEstado(String value) => setField<String>('id_estado', value);

  String? get nombre => getField<String>('nombre');
  set nombre(String? value) => setField<String>('nombre', value);
}
