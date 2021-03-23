#ifndef P1S3_GESTORFILTROS_H
#define P1S3_GESTORFILTROS_H


#include "Notas.h"
#include "CadenaFiltros.h"

class GestorFiltros {
    CadenaFiltros cadenaFiltros;
public:
    Notas& peticionFiltros(Notas& notas);
};


#endif //P1S3_GESTORFILTROS_H
