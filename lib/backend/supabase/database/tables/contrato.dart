import '../database.dart';

class ContratoTable extends SupabaseTable<ContratoRow> {
  @override
  String get tableName => 'contrato';

  @override
  ContratoRow createRow(Map<String, dynamic> data) => ContratoRow(data);
}

class ContratoRow extends SupabaseDataRow {
  ContratoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ContratoTable();

  int get idContrato => getField<int>('id_contrato')!;
  set idContrato(int value) => setField<int>('id_contrato', value);

  DateTime get fechaIniCon => getField<DateTime>('fecha_ini_con')!;
  set fechaIniCon(DateTime value) => setField<DateTime>('fecha_ini_con', value);

  DateTime? get fechaTerCon => getField<DateTime>('fecha_ter_con');
  set fechaTerCon(DateTime? value) =>
      setField<DateTime>('fecha_ter_con', value);

  String get idUsuario => getField<String>('id_usuario')!;
  set idUsuario(String value) => setField<String>('id_usuario', value);

  String? get idRemuneracion => getField<String>('id_remuneracion');
  set idRemuneracion(String? value) =>
      setField<String>('id_remuneracion', value);

  int? get idTipoContrato => getField<int>('id_tipo_contrato');
  set idTipoContrato(int? value) => setField<int>('id_tipo_contrato', value);

  String? get idEstado => getField<String>('id_estado');
  set idEstado(String? value) => setField<String>('id_estado', value);
}
