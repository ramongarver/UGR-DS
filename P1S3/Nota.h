#ifndef P1S3_NOTA_H
#define P1S3_NOTA_H

#include "TipoNota.h"

class Nota {
    TipoNota tipoNota;
    double nota;
    double pesoFinal;

public:
    Nota(TipoNota tipoNota, double nota);

    TipoNota getTipoNota() const { return tipoNota; }

    double getNota() const { return nota; }

    void setTipoNota(TipoNota tipoNota) { Nota::tipoNota = tipoNota; };

    void setNota(double nota) { Nota::nota = nota; }

    void setPesoFinal(double pesoFinal) { Nota::pesoFinal = pesoFinal; }
};


#endif //P1S3_NOTA_H
