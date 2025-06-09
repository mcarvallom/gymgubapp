import '../database.dart';

class PrevisionSaludTable extends SupabaseTable<PrevisionSaludRow> {
  @override
  String get tableName => 'prevision_salud';

  @override
  PrevisionSaludRow createRow(Map<String, dynamic> data) =>
      PrevisionSaludRow(data);
}

class PrevisionSaludRow extends SupabaseDataRow {
  PrevisionSaludRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PrevisionSaludTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);

  double get descuento => getField<double>('descuento')!;
  set descuento(double value) => setField<double>('descuento', value);
}
