#include "GestorFiltros.h"
#include "CadenaFiltros.h"


Notas& GestorFiltros::peticionFiltros(Notas &notas) {
    Notas& res = cadenaFiltros.ejecutar(notas);
    return res;
}
