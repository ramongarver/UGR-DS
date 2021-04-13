#include "Notas.h"

#ifndef P1S3_FILTRO_H
#define P1S3_FILTRO_H


class Filtro {
public:
    virtual void ejecutar(Notas &notas) const = 0;
};

#endif //P1S3_FILTRO_H
