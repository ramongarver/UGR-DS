import 'nota.dart';
import 'tipo_nota.dart';

class Notas {
  final _notas = <Nota>[];

  int get size => _notas.length;

  void addNota(TipoNota t, double n) => _notas.add(Nota(t, n));

  Nota getNota(int i) => _notas[i];
}