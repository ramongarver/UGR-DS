//
// Created by danip on 06/04/2021.
//

#ifndef P1S3_OBJETIVOVERNOTAS_H
#define P1S3_OBJETIVOVERNOTAS_H


#include "Notas.h"

class ObjetivoVerNotas {
    std::pair<double,double> finalTeoria = std::make_pair(0.0, 0.0);
    std::pair<double,double> finalPracticas = std::make_pair(0.0, 0.0);
    std::pair<double,double> finalTotal = std::make_pair(0.0, 0.0);
    static std::pair<double,double> calcularFinal(Notas&, TipoNota);

public:
    void ejecutar(Notas&);
};


#endif //P1S3_OBJETIVOVERNOTAS_H
