#include "include/GestorFiltros.h"


void GestorFiltros::peticionFiltros(TipoNota t, double n) {
    notas.addNota(t, n);
    cadenaFiltros.ejecutar(notas);
    objetivo.ejecutar(notas);
}

void GestorFiltros::addFiltro(Filtro & filtro) {
    cadenaFiltros.addFiltro(filtro);
}
