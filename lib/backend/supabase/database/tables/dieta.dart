import '../database.dart';

class DietaTable extends SupabaseTable<DietaRow> {
  @override
  String get tableName => 'dieta';

  @override
  DietaRow createRow(Map<String, dynamic> data) => DietaRow(data);
}

class DietaRow extends SupabaseDataRow {
  DietaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DietaTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime? get fechaCreacion => getField<DateTime>('fecha_creacion');
  set fechaCreacion(DateTime? value) =>
      setField<DateTime>('fecha_creacion', value);

  String? get usuarioId => getField<String>('usuario_id');
  set usuarioId(String? value) => setField<String>('usuario_id', value);

  String? get objetivo => getField<String>('objetivo');
  set objetivo(String? value) => setField<String>('objetivo', value);

  String? get preparacion => getField<String>('preparacion');
  set preparacion(String? value) => setField<String>('preparacion', value);

  int? get diasSemana => getField<int>('dias_semana');
  set diasSemana(int? value) => setField<int>('dias_semana', value);

  String? get notas => getField<String>('notas');
  set notas(String? value) => setField<String>('notas', value);

  String? get tipo => getField<String>('tipo');
  set tipo(String? value) => setField<String>('tipo', value);
}
