# cmake_minimum_required(VERSION <specify CMake version here>)
project(P1S3)

set(CMAKE_CXX_STANDARD 11)

include_directories(include)

add_executable(P1S3 src/main.cpp src/Nota.cpp include/Nota.h include/TipoNota.h include/Filtro.h src/FiltroPracticas.cpp include/FiltroPracticas.h src/FiltroTeoria.cpp include/FiltroTeoria.h src/Notas.cpp include/Notas.h src/GestorFiltros.cpp include/GestorFiltros.h src/CadenaFiltros.cpp include/CadenaFiltros.h src/ObjetivoVerNotas.cpp include/ObjetivoVerNotas.h)