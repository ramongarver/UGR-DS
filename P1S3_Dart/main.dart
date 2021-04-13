import 'dart:io';
import 'dart:math';

import 'filtro_practicas.dart';
import 'filtro_teoria.dart';
import 'gestor_filtros.dart';
import 'tipo_nota.dart';


double doubleInRange(Random source, double start, double end) =>
    source.nextDouble() * (end - start) + start;

void main() {
  final gestorFiltros = GestorFiltros();
  final filtroTeoria = FiltroTeoria(0.7);
  final filtroPracticas = FiltroPracticas(0.3);

  gestorFiltros.addFiltro(filtroTeoria);
  gestorFiltros.addFiltro(filtroPracticas);

  double notaTeoria, notaPracticas;

  Random r = Random();
  while(true) {
    sleep(Duration(milliseconds:500));

    notaTeoria = doubleInRange(r, 0.0, 10.0);
    print("Se añade nota de teoría: ${notaTeoria.toStringAsFixed(2)}");
    gestorFiltros.peticionFiltros(TipoNota.teoria, notaTeoria);

    notaPracticas = doubleInRange(r, 0.0, 10.0);
    print("Se añade nota de prácticas: ${notaPracticas.toStringAsFixed(2)}");
    gestorFiltros.peticionFiltros(TipoNota.practicas, notaPracticas);
  }
}
