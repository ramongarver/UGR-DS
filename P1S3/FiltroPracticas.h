#include "Filtro.h"
#include "Notas.h"

#ifndef P1S3_FILTROPRACTICAS_H
#define P1S3_FILTROPRACTICAS_H


class FiltroPracticas : public Filtro {
    static constexpr double coeficientePracticas = 0.4;
public:
    virtual Notas& aplicarPorcentaje(Notas &notas) const;
};


#endif //P1S3_FILTROPRACTICAS_H
