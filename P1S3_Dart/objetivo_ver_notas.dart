import 'nota.dart';
import 'notas.dart';
import 'tipo_nota.dart';

class ObjetivoVerNotas {
  double finalTeoria = 0.0;
  double finalPracticas = 0.0;
  double finalTotal = 0.0;

  double _calcularFinal(Notas notas, TipoNota tipoNota) {
    double notaFinal = 0.0;
    var size = notas.size;
    
    for(int i = 0; i < size; i++) {
      Nota n = notas.getNota(i);
      if(n.tipoNota == tipoNota)
        notaFinal += n.pesoFinal;
    }
    
    return notaFinal;
  }

  void ejecutar(Notas notas) {
    double finalTeoria = _calcularFinal(notas, TipoNota.teoria);
    double finalPracticas = _calcularFinal(notas, TipoNota.practicas);
    double finalTotal = finalPracticas + finalTeoria;
    
    print("Final teoria: ${finalTeoria}");
    print("Final practicas: ${finalPracticas}");
    print("Final total: ${finalTotal}");
  }
}