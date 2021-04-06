//
// Created by danip on 06/04/2021.
//

#include <iostream>
#include "include/ObjetivoVerNotas.h"

void ObjetivoVerNotas::ejecutar(Notas& notas) {
    finalTeoria = calcularFinal(notas, TipoNota::teoria);
    finalPracticas = calcularFinal(notas, TipoNota::practicas);
    finalTotal = finalTeoria + finalPracticas;

    std::cout << "Final teoria: " << finalTeoria << std::endl;
    std::cout << "Final practicas: " << finalPracticas << std::endl;
    std::cout << "------------------------------------" << std::endl;
    std::cout << "Final total: " << finalTotal << std::endl << std::endl << std::endl;
}

double ObjetivoVerNotas::calcularFinal(Notas &notas, TipoNota tipoNota) {
    double final = 0.0;
    size_t size = notas.size();
    for(size_t i = 0; i < size; i++) {
        Nota& n = notas.getNota(i);
        if(n.getTipoNota() == tipoNota)
            final += n.getPesoFinal();
    }

    return final;
}
