#include "CadenaFiltros.h"

Notas& CadenaFiltros::ejecutar(Notas & notas) {
    Notas &res = notas;
    for(const Filtro &f : cadenaFiltros) {
        res = f.aplicarPorcentaje(notas);
    }
    return res;
}