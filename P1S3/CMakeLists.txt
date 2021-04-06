# cmake_minimum_required(VERSION <specify CMake version here>)
project(P1S3)

set(CMAKE_CXX_STANDARD 11)

add_executable(P1S3 main.cpp Nota.cpp include/Nota.h include/TipoNota.h include/Filtro.h FiltroPracticas.cpp include/FiltroPracticas.h FiltroTeoria.cpp include/FiltroTeoria.h Notas.cpp include/Notas.h GestorFiltros.cpp include/GestorFiltros.h CadenaFiltros.cpp include/CadenaFiltros.h ObjetivoVerNotas.cpp include/ObjetivoVerNotas.h)