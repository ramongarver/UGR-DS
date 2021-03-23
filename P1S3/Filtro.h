#include "TipoNota.h"
#include "Notas.h"

#ifndef P1S3_FILTRO_H
#define P1S3_FILTRO_H


class Filtro {
public:
    virtual Notas& aplicarPorcentaje(Notas &notas) const = 0;
};

#endif //P1S3_FILTRO_H
