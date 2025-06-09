import '../database.dart';

class AfpTable extends SupabaseTable<AfpRow> {
  @override
  String get tableName => 'afp';

  @override
  AfpRow createRow(Map<String, dynamic> data) => AfpRow(data);
}

class AfpRow extends SupabaseDataRow {
  AfpRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AfpTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get nombre => getField<String>('nombre')!;
  set nombre(String value) => setField<String>('nombre', value);

  double get descuento => getField<double>('descuento')!;
  set descuento(double value) => setField<double>('descuento', value);
}
