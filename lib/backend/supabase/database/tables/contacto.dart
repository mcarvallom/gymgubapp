import '../database.dart';

class ContactoTable extends SupabaseTable<ContactoRow> {
  @override
  String get tableName => 'contacto';

  @override
  ContactoRow createRow(Map<String, dynamic> data) => ContactoRow(data);
}

class ContactoRow extends SupabaseDataRow {
  ContactoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ContactoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get direccion => getField<String>('direccion');
  set direccion(String? value) => setField<String>('direccion', value);

  double? get numContacto => getField<double>('num_contacto');
  set numContacto(double? value) => setField<double>('num_contacto', value);

  String? get nombreSucursal => getField<String>('nombre_sucursal');
  set nombreSucursal(String? value) =>
      setField<String>('nombre_sucursal', value);
}
