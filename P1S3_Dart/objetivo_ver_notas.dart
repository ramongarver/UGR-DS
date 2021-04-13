import 'nota.dart';
import 'notas.dart';
import 'tipo_nota.dart';

class ObjetivoVerNotas {
  double finalTeoria = 0.0;
  double finalPracticas = 0.0;
  double finalTotal = 0.0;
  double maximoFinalTotal = 0.0;

  Map _calcularFinal(Notas notas, TipoNota tipoNota) {
    double notaFinal = 0.0;
    double maximaFinal = 0.0;
    var size = notas.size;
    
    for(int i = 0; i < size; i++) {
      Nota n = notas.getNota(i);
      if(n.tipoNota == tipoNota) {
        notaFinal += n.pesoFinal;
        maximaFinal += n.maximoPesoFinal;
      }

    }
    
    return {'notaFinal' : notaFinal, 'maximaFinal' : maximaFinal};
  }

  void ejecutar(Notas notas) {
    final finalTeoria = _calcularFinal(notas, TipoNota.teoria);
    final finalPracticas = _calcularFinal(notas, TipoNota.practicas);
    finalTotal = finalPracticas['notaFinal'] + finalTeoria['notaFinal'];
    maximoFinalTotal = finalPracticas['maximaFinal'] + finalTeoria['maximaFinal'];

    print("Final teoría: ${finalTeoria['notaFinal'].toStringAsFixed(2)}"
        "/ ${(finalTeoria['maximaFinal'] * 10).toStringAsFixed(2)} ");
    print("Final prácticas: ${finalPracticas['notaFinal'].toStringAsFixed(2)} "
        "/ ${(finalPracticas['maximaFinal'] * 10).toStringAsFixed(2)}");
    print("------------------------------------");
    print("Final total: ${finalTotal.toStringAsFixed(2)} "
        "/ ${(maximoFinalTotal * 10).toStringAsFixed(2)}\n");
  }
}