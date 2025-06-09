import '../database.dart';

class TipoContratoTable extends SupabaseTable<TipoContratoRow> {
  @override
  String get tableName => 'tipo_contrato';

  @override
  TipoContratoRow createRow(Map<String, dynamic> data) => TipoContratoRow(data);
}

class TipoContratoRow extends SupabaseDataRow {
  TipoContratoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TipoContratoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get nombre => getField<String>('nombre');
  set nombre(String? value) => setField<String>('nombre', value);

  double? get descuento => getField<double>('descuento');
  set descuento(double? value) => setField<double>('descuento', value);
}
