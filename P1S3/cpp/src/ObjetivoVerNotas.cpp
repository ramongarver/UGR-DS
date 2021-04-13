//
// Created by danip on 06/04/2021.
//

#include <iostream>
#include "include/ObjetivoVerNotas.h"

void ObjetivoVerNotas::ejecutar(Notas& notas) {
    finalTeoria = calcularFinal(notas, TipoNota::teoria);
    finalPracticas = calcularFinal(notas, TipoNota::practicas);
    finalTotal.first = finalTeoria.first + finalPracticas.first;
    finalTotal.second = finalTeoria.second + finalPracticas.second;

    std::cout << "Final teoría: " << finalTeoria.first << "/" << finalTeoria.second * 10 <<std::endl;
    std::cout << "Final prácticas: " << finalPracticas.first << "/" << finalPracticas.second * 10 << std::endl;
    std::cout << "------------------------------------" << std::endl;
    std::cout << "Final total: " << finalTotal.first << "/" <<  finalTotal.second * 10 << std::endl << std::endl;
}

std::pair<double, double> ObjetivoVerNotas::calcularFinal(Notas &notas, TipoNota tipoNota) {
    double final = 0.0;
    double maximoFinal = 0.0;
    size_t size = notas.size();
    for(size_t i = 0; i < size; i++) {
        Nota& n = notas.getNota(i);
        if(n.getTipoNota() == tipoNota) {
            final += n.getPesoFinal().first;
            maximoFinal += n.getPesoFinal().second;
        }
    }

    return std::make_pair(final, maximoFinal);
}
