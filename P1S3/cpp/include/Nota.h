#ifndef P1S3_NOTA_H
#define P1S3_NOTA_H

#include <utility>
#include "TipoNota.h"

class Nota {
    TipoNota tipoNota;
    double nota;
    std::pair<double, double> pesoFinal;

public:
    Nota(TipoNota tipoNota, double nota);

    TipoNota getTipoNota() const { return tipoNota; }

    double getNota() const { return nota; }

    std::pair<double, double> getPesoFinal() const { return pesoFinal; }

    void setTipoNota(TipoNota tipo) { tipoNota = tipo; };

    void setNota(double n) { Nota::nota = n; }

    void setPesoFinal(double peso) { pesoFinal.first = peso; }
    void setMaximoPesoFinal(double maximoPeso) { pesoFinal.second = maximoPeso; }
};


#endif //P1S3_NOTA_H
