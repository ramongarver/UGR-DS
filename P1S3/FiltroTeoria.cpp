#include "include/FiltroTeoria.h"

void FiltroTeoria::ejecutar(Notas &notas) const {
    size_t size_teoria = 0;

    for (int i = 0; i < notas.size(); i++) {
        if(notas.getNota(i).getTipoNota() == TipoNota::teoria)
            size_teoria++;
    }

    for (int i = 0; i < notas.size(); i++) {
        Nota &n = notas.getNota(i);
        if (n.getTipoNota() == TipoNota::teoria) {
            n.setPesoFinal(n.getNota() * coeficienteTeoria / size_teoria);
        }
    }
}