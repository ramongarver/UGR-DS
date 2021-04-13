import 'tipo_nota.dart';

class Nota {
  TipoNota tipoNota;
  double nota;
  double pesoFinal = 0.0;
  double maximoPesoFinal = 0.0;

  Nota(this.tipoNota, this.nota);
}