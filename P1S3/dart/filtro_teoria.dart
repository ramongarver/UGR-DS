import 'filtro.dart';
import 'notas.dart';
import 'tipo_nota.dart';

class FiltroTeoria extends Filtro {
  double coeficienteTeoria;

  FiltroTeoria([this.coeficienteTeoria = 0.7]);

  void ejecutar(Notas notas) {
    var sizeTeoria = 0;

    for(int i = 0; i < notas.size; i++) {
      if(notas.getNota(i).tipoNota == TipoNota.teoria) {
        sizeTeoria++;
      }
    }

    for(int i = 0; i < notas.size; i++) {
      final n = notas.getNota(i);
      if(n.tipoNota == TipoNota.teoria) {
        n.pesoFinal = n.nota * coeficienteTeoria / sizeTeoria;
        n.maximoPesoFinal = coeficienteTeoria / sizeTeoria;
      }
    }
  }
}