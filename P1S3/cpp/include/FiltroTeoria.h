#include "Filtro.h"
#include "Notas.h"

#ifndef P1S3_FILTROTEORIA_H
#define P1S3_FILTROTEORIA_H


class FiltroTeoria : public Filtro {
    double coeficienteTeoria;
public:
    explicit FiltroTeoria(double coeficienteTeoria = 0.6) : coeficienteTeoria(coeficienteTeoria) {}

    double getCoeficiente() const { return coeficienteTeoria; }
    void ejecutar(Notas &notas) const override;
};


#endif //P1S3_FILTROTEORIA_H
