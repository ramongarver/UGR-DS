import 'filtro.dart';
import 'notas.dart';
import 'tipo_nota.dart';

class FiltroPracticas extends Filtro {
  double coeficientePracticas;

  FiltroPracticas([this.coeficientePracticas = 0.3]);

  void ejecutar(Notas notas) {
    var sizePracticas = 0;

    for(int i = 0; i < notas.size; i++) {
      if(notas.getNota(i).tipoNota == TipoNota.practicas) {
        sizePracticas++;
      }
    }

    for(int i = 0; i < notas.size; i++) {
      final n = notas.getNota(i);
      if(n.tipoNota == TipoNota.practicas) {
        n.pesoFinal = n.nota * coeficientePracticas / sizePracticas;
        n.maximoPesoFinal = coeficientePracticas / sizePracticas;
      }
    }
  }
}