#include <iostream>
#include "include/GestorFiltros.h"
#include "include/FiltroTeoria.h"
#include "include/FiltroPracticas.h"

int main() {

    GestorFiltros gestorFiltros = GestorFiltros();
    FiltroTeoria filtroTeoria = FiltroTeoria(0.7);
    FiltroPracticas filtroPracticas = FiltroPracticas(0.3);
    gestorFiltros.addFiltro(filtroTeoria);
    gestorFiltros.addFiltro(filtroPracticas);

    gestorFiltros.peticionFiltros(TipoNota::teoria, 9.5);
    gestorFiltros.peticionFiltros(TipoNota::practicas, 9);

    return 0;
}
