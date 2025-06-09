import '../database.dart';

class ComidasRecomendadasTable extends SupabaseTable<ComidasRecomendadasRow> {
  @override
  String get tableName => 'comidas_recomendadas';

  @override
  ComidasRecomendadasRow createRow(Map<String, dynamic> data) =>
      ComidasRecomendadasRow(data);
}

class ComidasRecomendadasRow extends SupabaseDataRow {
  ComidasRecomendadasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ComidasRecomendadasTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get recomendacionId => getField<int>('recomendacion_id');
  set recomendacionId(int? value) => setField<int>('recomendacion_id', value);

  List<String> get tipoComida => getListField<String>('tipo_comida');
  set tipoComida(List<String>? value) =>
      setListField<String>('tipo_comida', value);

  String? get descripcion => getField<String>('descripcion');
  set descripcion(String? value) => setField<String>('descripcion', value);

  dynamic get ingredientes => getField<dynamic>('ingredientes');
  set ingredientes(dynamic value) => setField<dynamic>('ingredientes', value);

  double? get caloriasTotales => getField<double>('calorias_totales');
  set caloriasTotales(double? value) =>
      setField<double>('calorias_totales', value);

  String? get notasIa => getField<String>('notas_ia');
  set notasIa(String? value) => setField<String>('notas_ia', value);
}
