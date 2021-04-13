import 'nota.dart';
import 'notas.dart';
import 'tipo_nota.dart';

class ObjetivoVerNotas {
  Map _finalTeoria = {'notaFinal' : 0.0, 'maximaFinal' : 0.0};
  Map _finalPracticas = {'notaFinal' : 0.0, 'maximaFinal' : 0.0};
  Map _finalTotal = {'notaFinal' : 0.0, 'maximaFinal' : 0.0};

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
    _finalTeoria = _calcularFinal(notas, TipoNota.teoria);
    _finalPracticas = _calcularFinal(notas, TipoNota.practicas);
    _finalTotal['notaFinal'] = _finalPracticas['notaFinal'] + _finalTeoria['notaFinal'];
    _finalTotal['maximaFinal'] = _finalPracticas['maximaFinal'] + _finalTeoria['maximaFinal'];

    print("Final teoría: ${_finalTeoria['notaFinal'].toStringAsFixed(2)}"
        "/ ${(_finalTeoria['maximaFinal'] * 10).toStringAsFixed(2)} ");
    print("Final prácticas: ${_finalPracticas['notaFinal'].toStringAsFixed(2)} "
        "/ ${(_finalPracticas['maximaFinal'] * 10).toStringAsFixed(2)}");
    print("------------------------------------");
    print("Final total: ${_finalTotal['notaFinal'].toStringAsFixed(2)} "
        "/ ${(_finalTotal['maximaFinal'] * 10).toStringAsFixed(2)}\n");
  }
}