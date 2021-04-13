#ifndef P1S3_GESTORFILTROS_H
#define P1S3_GESTORFILTROS_H


#include "Notas.h"
#include "CadenaFiltros.h"
#include "ObjetivoVerNotas.h"

class GestorFiltros {
    Notas notas;
    CadenaFiltros cadenaFiltros;
    ObjetivoVerNotas objetivo;

public:
    void addFiltro(Filtro&);
    void peticionFiltros(TipoNota, double);
};


#endif //P1S3_GESTORFILTROS_H
