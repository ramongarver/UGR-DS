#ifndef P1S3_CADENAFILTROS_H
#define P1S3_CADENAFILTROS_H


#include <vector>
#include "Filtro.h"

class CadenaFiltros {
    std::vector<Filtro> cadenaFiltros;

public:
    Notas& ejecutar(Notas&);
};


#endif //P1S3_CADENAFILTROS_H
