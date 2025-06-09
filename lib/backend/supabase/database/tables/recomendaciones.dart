import '../database.dart';

class RecomendacionesTable extends SupabaseTable<RecomendacionesRow> {
  @override
  String get tableName => 'recomendaciones';

  @override
  RecomendacionesRow createRow(Map<String, dynamic> data) =>
      RecomendacionesRow(data);
}

class RecomendacionesRow extends SupabaseDataRow {
  RecomendacionesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RecomendacionesTable();

  int get recomendacionId => getField<int>('recomendacion_id')!;
  set recomendacionId(int value) => setField<int>('recomendacion_id', value);

  DateTime get fechaCreacion => getField<DateTime>('fecha_creacion')!;
  set fechaCreacion(DateTime value) =>
      setField<DateTime>('fecha_creacion', value);

  String? get usuarioId => getField<String>('usuario_id');
  set usuarioId(String? value) => setField<String>('usuario_id', value);

  DateTime? get validaHasta => getField<DateTime>('valida_hasta');
  set validaHasta(DateTime? value) => setField<DateTime>('valida_hasta', value);

  int? get caloriasDiarias => getField<int>('calorias_diarias');
  set caloriasDiarias(int? value) => setField<int>('calorias_diarias', value);

  dynamic get macronutrientes => getField<dynamic>('macronutrientes');
  set macronutrientes(dynamic value) =>
      setField<dynamic>('macronutrientes', value);

  dynamic get micronutrientesPriorizados =>
      getField<dynamic>('micronutrientes_priorizados');
  set micronutrientesPriorizados(dynamic value) =>
      setField<dynamic>('micronutrientes_priorizados', value);

  int? get comidasDia => getField<int>('comidas_dia');
  set comidasDia(int? value) => setField<int>('comidas_dia', value);
}
