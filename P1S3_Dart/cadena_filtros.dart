import 'filtro.dart';
import 'notas.dart';

class CadenaFiltros {
  final _cadenaFiltros = <Filtro>[];

  void ejecutar(Notas notas) {
    for(var f in _cadenaFiltros) {
      f.ejecutar(notas);
    }
  }

  void addFiltro(Filtro filtro) {
    _cadenaFiltros.add(filtro);
  }
}