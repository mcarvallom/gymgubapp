import '../database.dart';

class EjerciciosTable extends SupabaseTable<EjerciciosRow> {
  @override
  String get tableName => 'ejercicios';

  @override
  EjerciciosRow createRow(Map<String, dynamic> data) => EjerciciosRow(data);
}

class EjerciciosRow extends SupabaseDataRow {
  EjerciciosRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EjerciciosTable();

  int get ejercicioId => getField<int>('ejercicio_id')!;
  set ejercicioId(int value) => setField<int>('ejercicio_id', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);

  String? get descripcion => getField<String>('descripcion');
  set descripcion(String? value) => setField<String>('descripcion', value);

  String get tipo => getField<String>('tipo')!;
  set tipo(String value) => setField<String>('tipo', value);

  String get intensidad => getField<String>('intensidad')!;
  set intensidad(String value) => setField<String>('intensidad', value);

  String? get grupoMuscularPrincipal =>
      getField<String>('grupo_muscular_principal');
  set grupoMuscularPrincipal(String? value) =>
      setField<String>('grupo_muscular_principal', value);

  bool? get equipamientoNecesario => getField<bool>('equipamiento_necesario');
  set equipamientoNecesario(bool? value) =>
      setField<bool>('equipamiento_necesario', value);
}
