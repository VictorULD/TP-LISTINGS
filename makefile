# =============================================================================
# MAKEFILE PARA TP-LISTINGS - VERSIÓN MANUAL Y SIMPLE
# Trabajo Práctico de Lenguajes de Programación III
# Implementación de listings del libro "Advanced Linux Programming"
# =============================================================================

# -----------------------------------------------------------------------------
# CONFIGURACIÓN DE COMPILADORES Y FLAGS
# -----------------------------------------------------------------------------

# Compilador para archivos C
CC = gcc
# Compilador para archivos C++
CXX = g++

# Flags de compilación para C (añadir -g para debug, -O2 para optimización)
CFLAGS = -Wall -Wextra -std=c99 -g
# Flags de compilación para C++ 
CXXFLAGS = -Wall -Wextra -std=c++11 -g
# Librerías que se van a enlazar (agregar más si necesitas, ej: -lpthread)
LDFLAGS = -lm

# -----------------------------------------------------------------------------
# DIRECTORIOS DEL PROYECTO
# -----------------------------------------------------------------------------

# Directorio donde están los archivos fuente
SRC_DIR = src
# Directorio donde van los ejecutables compilados
BIN_DIR = bin

# =============================================================================
# SECCIÓN DE LISTINGS - AQUÍ DEBES AGREGAR CADA LISTING MANUALMENTE
# =============================================================================

# -----------------------------------------------------------------------------
# CAPÍTULO 1 - LISTINGS
# -----------------------------------------------------------------------------

# LISTING 1.1 - main.c (requiere librería de 1.3)
# Archivos fuente del listing 1.1 + dependencias de otros listings
LISTING_1_1_SOURCES = $(SRC_DIR)/capitulo1/1.1/main.c $(SRC_DIR)/capitulo1/1.3/reciprocal.hpp
# Nombre del ejecutable
LISTING_1_1_TARGET = main
# Tipo de compilador (CXX porque incluye archivos .cpp)
LISTING_1_1_COMPILER = CC

# LISTING 1.2 - reciproco.cpp (requiere librería de 1.3) 
# Archivos fuente del listing 1.2 + dependencias de otros listings
LISTING_1_2_SOURCES = $(SRC_DIR)/capitulo1/1.2/reciprocal.cpp $(SRC_DIR)/capitulo1/1.3/reciprocal.hpp
# Nombre del ejecutable
LISTING_1_2_TARGET = reciprocal
# Tipo de compilador
LISTING_1_2_COMPILER = CXX

# LISTING 1.3 - Solo librería (reciproco.hpp + implementación)
LISTING_1_3_SOURCES = $(BIN_DIR)/capitulo1/1.1/main.o $(BIN_DIR)/capitulo1/1.2/reciprocal.o
# Nombre del ejecutable
LISTING_1_3_TARGET = reciprocal
# Tipo de compilador
LISTING_1_3_COMPILER = CXX


# -----------------------------------------------------------------------------
# CAPÍTULO 2 - LISTINGS (AGREGAR AQUÍ TUS LISTINGS DEL CAPÍTULO 2)
# -----------------------------------------------------------------------------

# EJEMPLO PARA AGREGAR UN LISTING DEL CAPÍTULO 2:
# LISTING_2_1_SOURCES = $(SRC_DIR)/capitulo2/2.1/archivo.c
# LISTING_2_1_TARGET = nombre_ejecutable
# LISTING_2_1_COMPILER = CC

# EJEMPLO CON MÚLTIPLES ARCHIVOS:
# LISTING_2_2_SOURCES = $(SRC_DIR)/capitulo2/2.2/main.c $(SRC_DIR)/capitulo2/2.2/utils.c
# LISTING_2_2_TARGET = programa
# LISTING_2_2_COMPILER = CC

# -----------------------------------------------------------------------------
# CAPÍTULO 3 - LISTINGS (AGREGAR AQUÍ TUS LISTINGS DEL CAPÍTULO 3)
# -----------------------------------------------------------------------------

# EJEMPLO DEL LISTING 3.1 MENCIONADO EN EL TP (print-pid.c):
# LISTING_3_1_SOURCES = $(SRC_DIR)/capitulo3/3.1/print-pid.c
# LISTING_3_1_TARGET = print-pid
# LISTING_3_1_COMPILER = CC

# -----------------------------------------------------------------------------
# CAPÍTULOS 4 Y 5 - LISTINGS (AGREGAR SEGÚN NECESITES)
# -----------------------------------------------------------------------------

# Seguir el mismo patrón para los capítulos restantes...

# =============================================================================
# GENERACIÓN AUTOMÁTICA DE REGLAS (NO MODIFICAR ESTA SECCIÓN)
# =============================================================================

# Función para generar reglas de compilación automáticamente
# Parámetros: $(1)=CAPITULO, $(2)=NUMERO (ej: 1, 1 para listing-1.1)
define make_listing_rule

# Solo crear regla si existen archivos fuente definidos
ifdef LISTING_$(1)_$(2)_SOURCES

# Determinar objetos intermedios (.o) basados en archivos fuente
LISTING_$(1)_$(2)_OBJECTS = \
  $$(patsubst $(SRC_DIR)/%.c,$(BIN_DIR)/%.o,$$(filter %.c,$$(LISTING_$(1)_$(2)_SOURCES))) \
  $$(patsubst $(SRC_DIR)/%.cpp,$(BIN_DIR)/%.o,$$(filter %.cpp,$$(LISTING_$(1)_$(2)_SOURCES)))

# Otros dependencias (headers, .o precompilados, etc.) — no se convierten a .o
LISTING_$(1)_$(2)_OTHER_DEPS = $$(filter-out %.c %.cpp,$$(LISTING_$(1)_$(2)_SOURCES))

# Path completo del ejecutable final
LISTING_$(1)_$(2)_FULL_TARGET = $(BIN_DIR)/capitulo$(1)/$$(LISTING_$(1)_$(2)_TARGET)

# Agregar a la lista de todos los targets
ALL_TARGETS += $$(LISTING_$(1)_$(2)_FULL_TARGET)

# Regla principal para compilar el listing específico (ej: make listing-1.1)
.PHONY: listing-$(1).$(2)
listing-$(1).$(2): $$(LISTING_$(1)_$(2)_FULL_TARGET)
	@echo "✓ Listing $(1).$(2) compilado exitosamente -> $$(LISTING_$(1)_$(2)_FULL_TARGET)"

# Regla para enlazar el ejecutable final
$$(LISTING_$(1)_$(2)_FULL_TARGET): $$(LISTING_$(1)_$(2)_OBJECTS)
	@echo "Enlazando listing $(1).$(2)..."
	@mkdir -p $$(dir $$@)
	@$$(if $$(filter CXX,$$(LISTING_$(1)_$(2)_COMPILER)),$$(CXX),$$(CC)) $$^ -o $$@ $$(LDFLAGS)

endif

endef

# -----------------------------------------------------------------------------
# GENERACIÓN DE TODAS LAS REGLAS
# -----------------------------------------------------------------------------

# Generar reglas para todos los listings definidos
# IMPORTANTE: Si agregas listings de otros capítulos, añádelos aquí también
$(eval $(call make_listing_rule,1,1))  # listing-1.1
$(eval $(call make_listing_rule,1,2))  # listing-1.2
$(eval $(call make_listing_rule,1,3))  # listing-1.3

# Ejemplo para agregar más listings:
# $(eval $(call make_listing_rule,2,1))  # listing-2.1
# $(eval $(call make_listing_rule,3,1))  # listing-3.1
# $(eval $(call make_listing_rule,3,2))  # listing-3.2

# =============================================================================
# REGLAS DE COMPILACIÓN DE ARCHIVOS OBJETO
# =============================================================================

# Regla para compilar archivos .c a archivos .o
$(BIN_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compilando (C): $<"
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Regla para compilar archivos .cpp a archivos .o  
$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp
	@echo "Compilando (C++): $<"
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# =============================================================================
# TARGETS PRINCIPALES REQUERIDOS POR EL TRABAJO PRÁCTICO
# =============================================================================

# Variable con todos los targets para compilar
ALL_TARGETS :=

# TARGET: make all
# Compila todos los programas desarrollados (REQUERIDO POR EL TP)
.PHONY: all
all: $(ALL_TARGETS)
	@echo "========================================="
	@echo "✓ COMPILACIÓN COMPLETADA"
	@echo "Total de programas compilados: $(words $(ALL_TARGETS))"
	@echo "========================================="

# TARGET: make clean  
# Elimina todas las compilaciones existentes (REQUERIDO POR EL TP)
.PHONY: clean
clean:
	@echo "Limpiando archivos compilados..."
	@rm -rf $(BIN_DIR)/*/*
	@echo "✓ Limpieza completada!"

# =============================================================================
# TARGETS DE INFORMACIÓN Y AYUDA
# =============================================================================

# TARGET: make info
# Muestra información sobre el proyecto y listings disponibles
.PHONY: info
info:
	@echo "========================================="
	@echo "INFORMACIÓN DEL PROYECTO TP-LISTINGS"
	@echo "========================================="
	@echo "Estructura:"
	@echo "  $(SRC_DIR)/ - Código fuente por capítulos"  
	@echo "  $(BIN_DIR)/ - Ejecutables compilados"
	@echo ""
	@echo "COMANDOS PRINCIPALES (Requeridos por el TP):"
	@echo "  make all           - Compila todos los programas"
	@echo "  make clean         - Elimina compilaciones"
	@echo "  make listing-X.Y   - Compila listing específico"
	@echo ""
	@echo "LISTINGS CONFIGURADOS ACTUALMENTE:"
	@echo "  make listing-1.1   - $(if $(LISTING_1_1_SOURCES),✓ Configurado,✗ No definido)"
	@echo "  make listing-1.2   - $(if $(LISTING_1_2_SOURCES),✓ Configurado,✗ No definido)"  
	@echo "  make listing-1.3   - $(if $(LISTING_1_3_SOURCES),✓ Configurado,✗ No definido)"
	@echo ""
	@echo "PARA AGREGAR NUEVOS LISTINGS:"
	@echo "  1. Edita el Makefile en la sección del capítulo correspondiente"
	@echo "  2. Define LISTING_X_Y_SOURCES, LISTING_X_Y_TARGET y LISTING_X_Y_COMPILER"
	@echo "  3. Agrega la línea: $$(eval $$(call make_listing_rule,X,Y))"
	@echo "  4. Ejecuta 'make listing-X.Y' para compilar"

# TARGET: make help
.PHONY: help  
help: info

# TARGET: make test
# Prueba que la estructura del proyecto sea correcta
.PHONY: test
test:
	@echo "========================================="
	@echo "VERIFICACIÓN DE ESTRUCTURA DEL PROYECTO"
	@echo "========================================="
	@echo "Verificando directorios principales..."
	@if [ -d "$(SRC_DIR)" ]; then echo "✓ $(SRC_DIR)/ existe"; else echo "✗ $(SRC_DIR)/ NO EXISTE"; fi
	@if [ -d "$(BIN_DIR)" ]; then echo "✓ $(BIN_DIR)/ existe"; else echo "✗ $(BIN_DIR)/ NO EXISTE"; fi
	@echo ""
	@echo "Archivos fuente encontrados:"
	@find $(SRC_DIR) -name "*.c" -o -name "*.cpp" | head -10 | while read file; do echo "  $$file"; done
	@echo ""
	@echo "Para compilar un listing específico:"
	@echo "  Ejemplo: make listing-1.1"

# =============================================================================
# INSTRUCCIONES DE USO
# =============================================================================

# =============================================================================
# INSTRUCCIONES DE USO Y CASOS ESPECIALES
# =============================================================================

# CÓMO AGREGAR UN NUEVO LISTING:
# 
# 1. Encuentra la sección del capítulo correspondiente arriba
# 2. Agrega las siguientes líneas (reemplaza X.Y con tu capítulo.listing):
#
#    LISTING_X_Y_SOURCES = $(SRC_DIR)/capituloX/X.Y/archivo1.c $(SRC_DIR)/capituloX/X.Y/archivo2.c
#    LISTING_X_Y_TARGET = nombre_del_ejecutable
#    LISTING_X_Y_COMPILER = CC    (usa CC para C, CXX para C++)
#
# 3. En la sección "GENERACIÓN DE TODAS LAS REGLAS", agrega:
#    $(eval $(call make_listing_rule,X,Y))

# =============================================================================
# CASOS ESPECIALES Y DEPENDENCIAS ENTRE LISTINGS
# =============================================================================

# CASO 1: LISTING CON DEPENDENCIAS DE OTROS LISTINGS (como 1.1 y 1.2)
# Cuando un listing necesita código de otro listing (ej: librerías, headers)
# 
# Ejemplo - Listing 1.1 necesita código de listing 1.3:
#   LISTING_1_1_SOURCES = $(SRC_DIR)/capitulo1/1.1/main.c $(SRC_DIR)/capitulo1/1.3/reciproco.cpp
#   LISTING_1_1_TARGET = main
#   LISTING_1_1_COMPILER = CXX  # Usar CXX si hay archivos .cpp
#
# ¿Por qué CXX? Porque si hay archivos .cpp en las dependencias, necesitas el compilador C++

# CASO 2: LISTING QUE ES SOLO UNA LIBRERÍA (como 1.3)
# Algunas veces un listing es solo un header + implementación que otros usan
# Opciones:
#   A) No crear regla de compilación (solo sirve como dependencia)
#   B) Crear regla de prueba/test si tiene función main
#
# Ejemplo A - Solo como dependencia (no genera ejecutable):
#   # No definir LISTING_1_3_SOURCES (comentado)
#
# Ejemplo B - Con programa de prueba:
#   LISTING_1_3_SOURCES = $(SRC_DIR)/capitulo1/1.3/test.cpp $(SRC_DIR)/capitulo1/1.3/reciproco.cpp
#   LISTING_1_3_TARGET = test-reciproco
#   LISTING_1_3_COMPILER = CXX

# CASO 3: MÚLTIPLES ARCHIVOS EN UN MISMO LISTING
# Cuando un listing tiene varios archivos fuente
#
# Ejemplo:
#   LISTING_4_2_SOURCES = $(SRC_DIR)/capitulo4/4.2/main.c $(SRC_DIR)/capitulo4/4.2/utils.c $(SRC_DIR)/capitulo4/4.2/network.c
#   LISTING_4_2_TARGET = servidor
#   LISTING_4_2_COMPILER = CC

# CASO 4: ARCHIVOS C Y C++ MEZCLADOS
# Si necesitas compilar archivos .c y .cpp juntos, usa CXX como compilador
#
# Ejemplo:
#   LISTING_5_1_SOURCES = $(SRC_DIR)/capitulo5/5.1/main.cpp $(SRC_DIR)/capitulo5/5.1/legacy.c
#   LISTING_5_1_TARGET = programa
#   LISTING_5_1_COMPILER = CXX  # CXX puede manejar tanto .c como .cpp

# EJEMPLOS COMPLETOS:
#
# Para un archivo C simple:
#   LISTING_3_1_SOURCES = $(SRC_DIR)/capitulo3/3.1/print-pid.c
#   LISTING_3_1_TARGET = print-pid
#   LISTING_3_1_COMPILER = CC
#   $(eval $(call make_listing_rule,3,1))
#
# Para múltiples archivos C++:
#   LISTING_4_2_SOURCES = $(SRC_DIR)/capitulo4/4.2/main.cpp $(SRC_DIR)/capitulo4/4.2/utils.cpp
#   LISTING_4_2_TARGET = programa
#   LISTING_4_2_COMPILER = CXX
#   $(eval $(call make_listing_rule,4,2))
#
# Para listing con dependencias cruzadas:
#   LISTING_2_1_SOURCES = $(SRC_DIR)/capitulo2/2.1/client.c $(SRC_DIR)/capitulo2/2.3/common.c
#   LISTING_2_1_TARGET = client
#   LISTING_2_1_COMPILER = CC
#   $(eval $(call make_listing_rule,2,1))

# Prevenir eliminación de archivos intermedios
.PRECIOUS: $(BIN_DIR)/%.o