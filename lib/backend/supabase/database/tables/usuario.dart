import '../database.dart';

class UsuarioTable extends SupabaseTable<UsuarioRow> {
  @override
  String get tableName => 'usuario';

  @override
  UsuarioRow createRow(Map<String, dynamic> data) => UsuarioRow(data);
}

class UsuarioRow extends SupabaseDataRow {
  UsuarioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsuarioTable();

  DateTime get fechaCreado => getField<DateTime>('fecha_creado')!;
  set fechaCreado(DateTime value) => setField<DateTime>('fecha_creado', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);

  String get apellido => getField<String>('apellido')!;
  set apellido(String value) => setField<String>('apellido', value);

  int? get rut => getField<int>('rut');
  set rut(int? value) => setField<int>('rut', value);

  String? get dv => getField<String>('dv');
  set dv(String? value) => setField<String>('dv', value);

  DateTime get fechaNac => getField<DateTime>('fecha_nac')!;
  set fechaNac(DateTime value) => setField<DateTime>('fecha_nac', value);

  String? get pasaporte => getField<String>('pasaporte');
  set pasaporte(String? value) => setField<String>('pasaporte', value);

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);

  double get numCel => getField<double>('num_cel')!;
  set numCel(double value) => setField<double>('num_cel', value);

  double? get numCelEmer => getField<double>('num_cel_emer');
  set numCelEmer(double? value) => setField<double>('num_cel_emer', value);

  String get direccion => getField<String>('direccion')!;
  set direccion(String value) => setField<String>('direccion', value);

  String? get estado => getField<String>('estado');
  set estado(String? value) => setField<String>('estado', value);

  String? get rol => getField<String>('rol');
  set rol(String? value) => setField<String>('rol', value);

  int? get peso => getField<int>('peso');
  set peso(int? value) => setField<int>('peso', value);

  double? get estatura => getField<double>('estatura');
  set estatura(double? value) => setField<double>('estatura', value);

  int get ciudad => getField<int>('ciudad')!;
  set ciudad(int value) => setField<int>('ciudad', value);

  int get region => getField<int>('region')!;
  set region(int value) => setField<int>('region', value);

  String get idUsuario => getField<String>('id_usuario')!;
  set idUsuario(String value) => setField<String>('id_usuario', value);

  int get genero => getField<int>('genero')!;
  set genero(int value) => setField<int>('genero', value);

  String? get creadoPor => getField<String>('creado_por');
  set creadoPor(String? value) => setField<String>('creado_por', value);

  String? get nivelUsuario => getField<String>('nivel_usuario');
  set nivelUsuario(String? value) => setField<String>('nivel_usuario', value);

  double? get pesoIdeal => getField<double>('peso_ideal');
  set pesoIdeal(double? value) => setField<double>('peso_ideal', value);

  String? get restriccionFisica => getField<String>('restriccion_fisica');
  set restriccionFisica(String? value) =>
      setField<String>('restriccion_fisica', value);

  String? get objetivoDieta => getField<String>('objetivoDieta');
  set objetivoDieta(String? value) => setField<String>('objetivoDieta', value);

  String? get objetivoEjercicio => getField<String>('objetivoEjercicio');
  set objetivoEjercicio(String? value) =>
      setField<String>('objetivoEjercicio', value);

  String? get imagenPerfil => getField<String>('imagenPerfil');
  set imagenPerfil(String? value) => setField<String>('imagenPerfil', value);

  String? get restriccionAlimentaria =>
      getField<String>('restriccion_alimentaria');
  set restriccionAlimentaria(String? value) =>
      setField<String>('restriccion_alimentaria', value);
}
