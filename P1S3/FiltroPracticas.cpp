#include "FiltroPracticas.h"

Notas& FiltroPracticas::aplicarPorcentaje(Notas &notas) const {
    double notaPonderada = 0.0;
    size_t size_practicas = 0;

    for (int i = 0; i < notas.size(); i++) {
        if(notas.getNota(i).getTipoNota() == TipoNota::practicas)
            size_practicas++;
    }

    for (int i = 0; i < notas.size(); i++) {
        Nota &n = notas.getNota(i);
        if (n.getTipoNota() == TipoNota::practicas) {
            n.setPesoFinal(n.getNota() * coeficientePracticas / size_practicas);
            n.setTipoNota(TipoNota::final);
        }
    }

    return notas;
}