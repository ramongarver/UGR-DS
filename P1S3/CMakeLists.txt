# cmake_minimum_required(VERSION <specify CMake version here>)
project(P1S3)

set(CMAKE_CXX_STANDARD 11)

add_executable(P1S3 main.cpp Nota.cpp Nota.h TipoNota.h Filtro.h FiltroPracticas.cpp FiltroPracticas.h FiltroTeoria.cpp FiltroTeoria.h Notas.cpp Notas.h GestorFiltros.cpp GestorFiltros.h CadenaFiltros.cpp CadenaFiltros.h)