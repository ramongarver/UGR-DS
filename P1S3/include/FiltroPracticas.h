#include "Filtro.h"
#include "Notas.h"

#ifndef P1S3_FILTROPRACTICAS_H
#define P1S3_FILTROPRACTICAS_H


class FiltroPracticas : public Filtro {
    double coeficientePracticas;
public:
    explicit FiltroPracticas(double coeficientePracticas = 0.4) : coeficientePracticas(coeficientePracticas) {}

    void ejecutar(Notas &notas) const override;
};


#endif //P1S3_FILTROPRACTICAS_H
