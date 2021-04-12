import 'filtro_practicas.dart';
import 'filtro_teoria.dart';
import 'gestor_filtros.dart';
import 'tipo_nota.dart';

void main() {
  final gestorFiltros = GestorFiltros();
  final filtroTeoria = FiltroTeoria(0.7);
  final filtroPracticas = FiltroPracticas(0.3);

  gestorFiltros.addFiltro(filtroTeoria);
  gestorFiltros.addFiltro(filtroPracticas);

  gestorFiltros.peticionFiltros(TipoNota.teoria, 9.5);
  gestorFiltros.peticionFiltros(TipoNota.practicas, 9);
}
