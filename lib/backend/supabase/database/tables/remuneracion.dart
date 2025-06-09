import '../database.dart';

class RemuneracionTable extends SupabaseTable<RemuneracionRow> {
  @override
  String get tableName => 'remuneracion';

  @override
  RemuneracionRow createRow(Map<String, dynamic> data) => RemuneracionRow(data);
}

class RemuneracionRow extends SupabaseDataRow {
  RemuneracionRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RemuneracionTable();

  String get idRemuneracion => getField<String>('id_remuneracion')!;
  set idRemuneracion(String value) =>
      setField<String>('id_remuneracion', value);

  String? get idUsuario => getField<String>('id_usuario');
  set idUsuario(String? value) => setField<String>('id_usuario', value);

  double get sueldoBruto => getField<double>('sueldo_bruto')!;
  set sueldoBruto(double value) => setField<double>('sueldo_bruto', value);

  double? get descuentos => getField<double>('descuentos');
  set descuentos(double? value) => setField<double>('descuentos', value);

  double? get sueldoLiquido => getField<double>('sueldo_liquido');
  set sueldoLiquido(double? value) => setField<double>('sueldo_liquido', value);

  DateTime get fechaPago => getField<DateTime>('fecha_pago')!;
  set fechaPago(DateTime value) => setField<DateTime>('fecha_pago', value);

  int? get idAfp => getField<int>('id_afp');
  set idAfp(int? value) => setField<int>('id_afp', value);

  int? get idPrevision => getField<int>('id_prevision');
  set idPrevision(int? value) => setField<int>('id_prevision', value);
}
