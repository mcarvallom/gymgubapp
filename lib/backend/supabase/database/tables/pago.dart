import '../database.dart';

class PagoTable extends SupabaseTable<PagoRow> {
  @override
  String get tableName => 'pago';

  @override
  PagoRow createRow(Map<String, dynamic> data) => PagoRow(data);
}

class PagoRow extends SupabaseDataRow {
  PagoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PagoTable();

  String get idPago => getField<String>('id_pago')!;
  set idPago(String value) => setField<String>('id_pago', value);

  String get idUsuario => getField<String>('id_usuario')!;
  set idUsuario(String value) => setField<String>('id_usuario', value);

  DateTime get fechaPago => getField<DateTime>('fecha_pago')!;
  set fechaPago(DateTime value) => setField<DateTime>('fecha_pago', value);

  int? get monto => getField<int>('monto');
  set monto(int? value) => setField<int>('monto', value);

  String get medioDePago => getField<String>('medio_de_pago')!;
  set medioDePago(String value) => setField<String>('medio_de_pago', value);

  String get estado => getField<String>('estado')!;
  set estado(String value) => setField<String>('estado', value);

  int? get idMembresia => getField<int>('id_membresia');
  set idMembresia(int? value) => setField<int>('id_membresia', value);
}
