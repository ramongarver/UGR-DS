#ifndef P1S3_CADENAFILTROS_H
#define P1S3_CADENAFILTROS_H

#include <functional>
#include <vector>
#include "Filtro.h"

class CadenaFiltros {
    std::vector<std::reference_wrapper<Filtro>> cadenaFiltros;

public:
    void ejecutar(Notas &notas);
    void addFiltro(Filtro&);
};


#endif //P1S3_CADENAFILTROS_H
