#include "FiltroTeoria.h"

Notas& FiltroTeoria::aplicarPorcentaje(Notas &notas) const {
    double notaPonderada = 0.0;
    size_t size_teoria = 0;

    for (int i = 0; i < notas.size(); i++) {
        if(notas.getNota(i).getTipoNota() == TipoNota::teoria)
            size_teoria++;
    }

    for (int i = 0; i < notas.size(); i++) {
        Nota &n = notas.getNota(i);
        if (n.getTipoNota() == TipoNota::practicas) {
            n.setPesoFinal(n.getNota() * coeficienteTeoria / size_teoria);
            n.setTipoNota(TipoNota::final);
        }
    }

    return notas;
}