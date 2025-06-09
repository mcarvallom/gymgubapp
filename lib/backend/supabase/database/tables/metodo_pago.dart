import '../database.dart';

class MetodoPagoTable extends SupabaseTable<MetodoPagoRow> {
  @override
  String get tableName => 'metodo_pago';

  @override
  MetodoPagoRow createRow(Map<String, dynamic> data) => MetodoPagoRow(data);
}

class MetodoPagoRow extends SupabaseDataRow {
  MetodoPagoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MetodoPagoTable();

  String get idMetodoPago => getField<String>('id_metodo_pago')!;
  set idMetodoPago(String value) => setField<String>('id_metodo_pago', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);
}
