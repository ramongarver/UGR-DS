#include "Filtro.h"
#include "Notas.h"

#ifndef P1S3_FILTROTEORIA_H
#define P1S3_FILTROTEORIA_H


class FiltroTeoria {
    static constexpr double coeficienteTeoria = 0.6;
public:
    virtual Notas& aplicarPorcentaje(Notas &notas) const;
};


#endif //P1S3_FILTROTEORIA_H
