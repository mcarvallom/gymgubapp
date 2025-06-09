
String ponerPuntoalMil(String numero) {
  // poner punto al mil
  String result = '';
  int count = 0;
  for (int i = numero.length - 1; i >= 0; i--) {
    result = numero[i] + result;
    count++;
    if (count % 3 == 0 && i != 0) {
      result = '.' + result;
    }
  }
  return result;
}

String obtenermes(DateTime? fechaActual) {
  // obtener mes español
  if (fechaActual == null) return '';
  List<String> meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  return meses[fechaActual.month - 1];
}

String obtenerdia(DateTime fechaActual) {
  // obtener dia español
  List<String> dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];
  return dias[fechaActual.weekday - 1];
}

int sumar(List<String> num) {
  // sumar desde string
  int suma = 0;
  for (String n in num) {
    suma += int.parse(n);
  }
  return suma;
}
