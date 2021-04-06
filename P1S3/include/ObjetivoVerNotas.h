//
// Created by danip on 06/04/2021.
//

#ifndef P1S3_OBJETIVOVERNOTAS_H
#define P1S3_OBJETIVOVERNOTAS_H


#include "Notas.h"

class ObjetivoVerNotas {
    double finalTeoria = 0.0;
    double finalPracticas = 0.0;
    double finalTotal = 0.0;
    static double calcularFinal(Notas&, TipoNota);

public:
    void ejecutar(Notas&);
};


#endif //P1S3_OBJETIVOVERNOTAS_H
