#include <iostream>
#include <iomanip>
#include <chrono>
#include <thread>
#include <random>
#include "GestorFiltros.h"
#include "FiltroTeoria.h"
#include "FiltroPracticas.h"

// Para que no de warning el bucle while(true)
#pragma clang diagnostic push
#pragma ide diagnostic ignored "EndlessLoop"


int main() {
    std::cout << std::fixed;
    std::cout << std::setprecision(2);

    GestorFiltros gestorFiltros = GestorFiltros();
    FiltroTeoria filtroTeoria = FiltroTeoria(0.7);
    FiltroPracticas filtroPracticas = FiltroPracticas(0.3);

    gestorFiltros.addFiltro(filtroTeoria);
    gestorFiltros.addFiltro(filtroPracticas);

    std::uniform_real_distribution<double> uniformRealDistribution(0.0, 10.0);
    std::random_device r;
    std::default_random_engine randomEngine(r());

    double notaTeoria, notaPracticas;

    while(true) {
        std::this_thread::sleep_for(std::chrono::milliseconds(500));

        notaTeoria = uniformRealDistribution(randomEngine);
        std::cout << "Se añade nota de teoría: " << notaTeoria << std::endl;
        gestorFiltros.peticionFiltros(TipoNota::teoria, notaTeoria);

        notaPracticas = uniformRealDistribution(randomEngine);
        std::cout << "Se añade nota de prácticas: " << notaPracticas << std::endl;
        gestorFiltros.peticionFiltros(TipoNota::practicas, notaPracticas);
    }

    return 0;
}

#pragma clang diagnostic pop