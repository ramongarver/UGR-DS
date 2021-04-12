import 'filtro.dart';
import 'notas.dart';
import 'tipo_nota.dart';

class FiltroTeoria extends Filtro {
  double _coeficienteTeoria;

  FiltroTeoria([this._coeficienteTeoria = 0.7]);

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
        n.pesoFinal = n.nota * _coeficienteTeoria / sizeTeoria;
      }
    }
  }
}