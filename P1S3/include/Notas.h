#include <vector>
#include "Nota.h"

#ifndef P1S3_NOTAS_H
#define P1S3_NOTAS_H

class Notas {
    std::vector<Nota> notas;

public:
    size_t size() const { return notas.size(); }

    void addNota(TipoNota t, double n) { notas.emplace_back(t, n); }

    Nota& getNota(size_t i) { return notas[i]; }
};


#endif //P1S3_NOTAS_H
