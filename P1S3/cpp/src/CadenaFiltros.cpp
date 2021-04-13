#include "include/CadenaFiltros.h"

void CadenaFiltros::ejecutar(Notas &notas) {
    for(const std::reference_wrapper<Filtro>& f : cadenaFiltros) {
        f.get().ejecutar(notas);
    }
}


void CadenaFiltros::addFiltro(Filtro& filtro) {
    cadenaFiltros.emplace_back(filtro);
}
