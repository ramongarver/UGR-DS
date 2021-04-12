import 'cadena_filtros.dart';
import 'filtro.dart';
import 'notas.dart';
import 'objetivo_ver_notas.dart';
import 'tipo_nota.dart';

class GestorFiltros {
  Notas _notas = Notas();
  CadenaFiltros _cadenaFiltros = CadenaFiltros();
  ObjetivoVerNotas _objetivo = ObjetivoVerNotas();

  void addFiltro(Filtro f) {
    _cadenaFiltros.addFiltro(f);
  }

  void peticionFiltros(TipoNota t, double n) {
    _notas.addNota(t, n);
    _cadenaFiltros.ejecutar(_notas);
    _objetivo.ejecutar(_notas);
  }
}