# Compilador para archivos C
CC = gcc
# Compilador para archivos C++
CXX = g++
# Herramienta para crear bibliotecas estáticas
AR = ar

# Flags de compilación
CFLAGS = -Wall -g -w
# Librerías que se van a enlazar
LDFLAGS = -lm 

# Directorio donde están los archivos fuente
SRC_DIR = src
# Directorio donde van los ejecutables compilados
BIN_DIR = bin

# =============================================================================
# Archivos fuente del listing (solo .c/.cpp)
# Directorios de headers (opcional)
# Nombre del ejecutable
# Tipo de compilador
# Tipo de salida: OBJECT (solo .o) o EXECUTABLE (ejecutable)
# =============================================================================
# =========================CAPITULO 1=========================================

# LISTING 1.1
LISTING_1_1_SOURCES = $(SRC_DIR)/capitulo1/1.1/main.c
LISTING_1_1_INCLUDES = $(SRC_DIR)/capitulo1/1.3
LISTING_1_1_TARGET = main
LISTING_1_1_COMPILER = CC
LISTING_1_1_TYPE = OBJECT

# LISTING 1.2
LISTING_1_2_SOURCES = $(SRC_DIR)/capitulo1/1.2/reciprocal.cpp
LISTING_1_2_INCLUDES = $(SRC_DIR)/capitulo1/1.3
LISTING_1_2_TARGET = reciprocal
LISTING_1_2_COMPILER = CXX
LISTING_1_2_TYPE = OBJECT

# LINK LISTING  1.1 y 1.2 - Ejecutable manual
LINK_OBJECTS = $(BIN_DIR)/capitulo1/1.1/main.o $(BIN_DIR)/capitulo1/1.2/reciprocal.o
LINK_EXECUTABLE = $(BIN_DIR)/capitulo1/reciprocal

# =============================================================================
# ==========================CAPITULO 2=========================================

# LISTING 2.1
LISTING_2_1_SOURCES = $(SRC_DIR)/capitulo2/2.1/arglist.c
LISTING_2_1_TARGET = arglist
LISTING_2_1_COMPILER = CC
LISTING_2_1_TYPE = EXECUTABLE

# LISTING 2.2
LISTING_2_2_SOURCES = $(SRC_DIR)/capitulo2/2.2/getopt_long.c
LISTING_2_2_TARGET = getopt_long
LISTING_2_2_COMPILER = CC
LISTING_2_2_TYPE = EXECUTABLE

# LISTING 2.3
LISTING_2_3_SOURCES = $(SRC_DIR)/capitulo2/2.3/print-env.c
LISTING_2_3_TARGET = print-env
LISTING_2_3_COMPILER = CC
LISTING_2_3_TYPE = EXECUTABLE

# LISTING 2.4
LISTING_2_4_SOURCES = $(SRC_DIR)/capitulo2/2.4/client.c
LISTING_2_4_TARGET = client
LISTING_2_4_COMPILER = CC
LISTING_2_4_TYPE = EXECUTABLE

# LISTING 2.5
LISTING_2_5_SOURCES = $(SRC_DIR)/capitulo2/2.5/temp_file.c
LISTING_2_5_TARGET = exmple_temp_file
LISTING_2_5_COMPILER = CC
LISTING_2_5_TYPE = EXECUTABLE

# LISTING 2.6
LISTING_2_6_SOURCES = $(SRC_DIR)/capitulo2/2.6/readfile.c
LISTING_2_6_TARGET = readfile
LISTING_2_6_COMPILER = CC
LISTING_2_6_TYPE = EXECUTABLE

# LISTING 2.7
LISTING_2_7_SOURCES = $(SRC_DIR)/capitulo2/2.7/test.c
LISTING_2_7_OBJECT_A = $(BIN_DIR)/capitulo2/2.7/test_a.o
LISTING_2_7_OBJECT_SO = $(BIN_DIR)/capitulo2/2.7/test_so.o
LISTING_2_7_TARGET_A = $(BIN_DIR)/capitulo2/libtest.a
LISTING_2_7_TARGET_SO = $(BIN_DIR)/capitulo2/libtest.so

# LISTING 2.8
LISTING_2_8_SOURCES = $(SRC_DIR)/capitulo2/2.8/app.c
LISTING_2_8_OBJECTS = $(BIN_DIR)/capitulo2/2.8/app.o
LISTING_2_8_TARGET = $(BIN_DIR)/capitulo2/app

# LISTING 2.9
LISTING_2_9_SOURCES = $(SRC_DIR)/capitulo2/2.9/tifftest.c
LISTING_2_9_TARGET = $(BIN_DIR)/capitulo2/tifftest
LISTING_2_9_LIBS = -ltiff

# =============================================================================

ALL_TARGETS := listing-1.1 listing-1.2 listing-1.LINK-1.1-1.2 listing-2.1 
ALL_TARGETS += listing-2.2 listing-2.3 listing-2.4 listing-2.5 listing-2.6
ALL_TARGETS += listing-2.7 listing-2.8

# =============================================================================

define make_listing_rule

# Solo crear regla si existen archivos fuente definidos
ifdef LISTING_$(1)_$(2)_SOURCES

# Determinar objetos intermedios (.o) basados en archivos fuente
LISTING_$(1)_$(2)_OBJECTS = $$(LISTING_$(1)_$(2)_SOURCES:$(SRC_DIR)/%.c=$(BIN_DIR)/%.o)
LISTING_$(1)_$(2)_OBJECTS := $$(LISTING_$(1)_$(2)_OBJECTS:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%.o)

# Construir flags de include si existen directorios
LISTING_$(1)_$(2)_INCLUDE_FLAGS = $$(if $$(LISTING_$(1)_$(2)_INCLUDES),$$(addprefix -I,$$(LISTING_$(1)_$(2)_INCLUDES)),)

# Determinar el target final basándose en el tipo
ifeq ($$(LISTING_$(1)_$(2)_TYPE),EXECUTABLE)
# Para ejecutables: bin/capituloX/target_name
LISTING_$(1)_$(2)_FULL_TARGET = $(BIN_DIR)/capitulo$(1)/$$(LISTING_$(1)_$(2)_TARGET)
else
# Para objetos: bin/capituloX/X.Y/target_name (mantener compatibilidad)
LISTING_$(1)_$(2)_FULL_TARGET = $(BIN_DIR)/capitulo$(1)/$(1).$(2)/$$(LISTING_$(1)_$(2)_TARGET)
endif

# Crear el target específico para este listing
.PHONY: listing-$(1).$(2)
listing-$(1).$(2): $$(LISTING_$(1)_$(2)_FULL_TARGET)

# Regla diferente según el tipo
ifeq ($$(LISTING_$(1)_$(2)_TYPE),EXECUTABLE)
# EJECUTABLE: Compilar objetos Y enlazar
$$(LISTING_$(1)_$(2)_FULL_TARGET): $$(LISTING_$(1)_$(2)_OBJECTS)
	@echo "========================================="
	@echo "Compilando ejecutable $(1).$(2)..."
	@echo "Archivos objeto: $$^"
	@mkdir -p $$(dir $$@)
	@$$(if $$(filter CXX,$$(LISTING_$(1)_$(2)_COMPILER)),$$(CXX),$$(CC)) $$^ -o $$@ $$(LDFLAGS)
	@echo "Ejecutable $(1).$(2) compilado exitosamente -> $$@"
	@echo "========================================="
else
# OBJETO: Solo compilar, no enlazar
$$(LISTING_$(1)_$(2)_FULL_TARGET): $$(LISTING_$(1)_$(2)_OBJECTS)
	@echo "========================================="
	@echo "Objetos $(1).$(2) compilados exitosamente"
	@echo "Archivos generados: $$^"
	@echo "========================================="
	@mkdir -p $$(dir $$@)
	@touch $$@  # Crear archivo marcador para make
endif

endif

endef

# =============================================================================

# Llamar a la función para cada listing definido

# ===================================
# CAPITULO 1
# ===================================
# Listing 1.1
$(eval $(call make_listing_rule,1,1))
# Listing 1.2
$(eval $(call make_listing_rule,1,2))

# Regla para enlazar listing 1.1 y 1.2
.PHONY: listing-1.LINK-1.1-1.2
listing-1.LINK-1.1-1.2: $(LINK_EXECUTABLE)

$(LINK_EXECUTABLE): $(LINK_OBJECTS)
	@echo "========================================="
	@echo "Enlazando main.o y reciprocal.o ..."
	@echo "Archivos objeto: $(LINK_OBJECTS)"
	@mkdir -p $(dir $@)
	$(CXX) $^ -o $@ $(LDFLAGS)
	@echo "Programa completo compilado exitosamente -> $@"
	@echo "========================================="

# ===================================
# CAPITULO 2
# ===================================
# Listing 2.1
$(eval $(call make_listing_rule,2,1))
# Listing 2.2
$(eval $(call make_listing_rule,2,2))
# Listing 2.3
$(eval $(call make_listing_rule,2,3))
# Listing 2.4
$(eval $(call make_listing_rule,2,4))
# Listing 2.5
$(eval $(call make_listing_rule,2,5))
# Listing 2.6
$(eval $(call make_listing_rule,2,6))
# Listing 2.7
.PHONY: listing-2.7
listing-2.7: $(LISTING_2_7_TARGET_A) $(LISTING_2_7_TARGET_SO)

$(LISTING_2_7_OBJECT_A): $(LISTING_2_7_SOURCES)
	@echo "========================================="
	@echo "Compilando objetos para listing-2.7..."
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "Archivo objeto compilado exitosamente -> $@"
	@echo "========================================="

$(LISTING_2_7_OBJECT_SO): $(LISTING_2_7_SOURCES)
	@echo "========================================="
	@echo "Compilando objetos para listing-2.7..."
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -fPIC -c $< -o $@
	@echo "Archivo objeto compilado exitosamente -> $@"
	@echo "========================================="

$(LISTING_2_7_TARGET_A): $(LISTING_2_7_OBJECT_A)
	@echo "Creando biblioteca estática para listing-2.7..."
	@mkdir -p $(dir $@)
	$(AR) rcs $@ $^
	@echo "Biblioteca estática creada exitosamente -> $@"
	@echo "========================================="

$(LISTING_2_7_TARGET_SO): $(LISTING_2_7_OBJECT_SO)
	@echo "Creando biblioteca compartida para listing-2.7..."
	@mkdir -p $(dir $@)
	$(CC) -shared -fPIC -o $@ $^ $(LDFLAGS)
	@echo "Biblioteca compartida creada exitosamente -> $@"
	@echo "========================================="

# Listing 2.8
.PHONY: listing-2.8
listing-2.8: $(LISTING_2_8_TARGET)

$(LISTING_2_8_TARGET): $(LISTING_2_8_SOURCES)
	@echo "Creando ejecutable para listing-2.8..."
	@mkdir -p $(dir $@)
	$(CC) $^ -o $@ -L./bin/capitulo2 -ltest
	@echo "Ejecutable creado exitosamente -> $@"
	@echo "========================================="

# Listing 2.9
.PHONY: listing-2.9
listing-2.9: $(LISTING_2_9_TARGET) $(LISTING_2_9_TARGET_STATIC)

$(LISTING_2_9_TARGET): $(LISTING_2_9_SOURCES)
	@echo "========================================="
	@echo "Creando ejecutable para listing-2.9..."
	@mkdir -p $(dir $@)
	$(CC) -o $@ $^ $(LISTING_2_9_LIBS)
	@echo "Ejecutable creado exitosamente -> $@"
	@echo "========================================="

# =============================================================================

# Función para obtener flags de include específicos para un archivo
define get_include_flags
$(strip \
  $(if $(LISTING_1_1_INCLUDES),$(if $(findstring capitulo1/1.1,$1),$(addprefix -I,$(LISTING_1_1_INCLUDES)))) \
  $(if $(LISTING_1_2_INCLUDES),$(if $(findstring capitulo1/1.2,$1),$(addprefix -I,$(LISTING_1_2_INCLUDES)))) \
)
endef

# Regla para compilar archivos .c a archivos .o
$(BIN_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "========================================="
	@echo "Compilando (C): $<"
	$(eval INCLUDE_FLAGS = $(call get_include_flags,$<))
	$(if $(strip $(INCLUDE_FLAGS)),@echo "Includes: $(INCLUDE_FLAGS)")
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -c $< -o $@

# Regla para compilar archivos .cpp a archivos .o  
$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp
	@echo "========================================="
	@echo "Compilando (C++): $<"
	$(eval INCLUDE_FLAGS = $(call get_include_flags,$<))
	$(if $(strip $(INCLUDE_FLAGS)),@echo "Includes: $(INCLUDE_FLAGS)")
	@mkdir -p $(dir $@)
	$(CXX) $(CFLAGS) $(INCLUDE_FLAGS) -c $< -o $@

# =============================================================================

.PHONY: all
all: $(ALL_TARGETS)
	@echo "========================================="
	@echo "COMPILACIÓN COMPLETADA"
	@echo "Total de programas compilados: $(words $(ALL_TARGETS))"
	@echo "========================================="

.PHONY: clean
clean:
	@echo "========================================="
	@echo "Limpiando archivos compilados..."
	@rm -rf $(BIN_DIR)/*/*
	@echo "Limpieza completada"
	@echo "========================================="

define filter_targets_by_chapter
$(filter listing-$(1).%,$(ALL_TARGETS))
endef

.PHONY: list
list:
	@if [ "$(filter-out list,$(MAKECMDGOALS))" ]; then \
		chapter="$(filter-out list,$(MAKECMDGOALS))"; \
		if echo "$$chapter" | grep -q '^[0-9]*$$'; then \
			echo "========================================="; \
			echo "Listings disponibles para el Capítulo $$chapter:"; \
			echo "========================================="; \
			targets=$$(echo "$(ALL_TARGETS)" | tr ' ' '\n' | grep "^listing-$$chapter\."); \
			if [ -n "$$targets" ]; then \
				echo "$$targets" | sed 's/^/  /'; \
			else \
				echo "  No se encontraron listings para el capítulo $$chapter"; \
			fi; \
			echo "========================================="; \
		else \
			echo "Error: '$$chapter' no es un número de capítulo válido"; \
			echo "Uso: make list [NUMERO_CAPITULO]"; \
		fi; \
	else \
		echo "========================================="; \
		echo "Listings disponibles para compilar:"; \
		current_chapter=""; \
		for target in $(ALL_TARGETS); do \
			chapter=$$(echo $$target | sed -n 's/listing-\([0-9]*\)\..*/\1/p'); \
			if [ "$$chapter" != "$$current_chapter" ]; then \
				if [ -n "$$current_chapter" ]; then echo ""; fi; \
				echo "Capítulo $$chapter:"; \
				current_chapter="$$chapter"; \
			fi; \
			echo "  $$target"; \
		done; \
		echo "========================================="; \
	fi

# Target especial para capturar argumentos numéricos después de list
%:
	@if echo "$@" | grep -q '^[0-9]*$$' && [ "$(word 1,$(MAKECMDGOALS))" = "list" ]; then \
		: ; \
	else \
		$(MAKE) $@; \
	fi

# =============================================================================

.PHONY: help  
help: 
	@echo "========================================="
	@echo "  make listing-X.Y   - Compila listing específico"
	@echo "  make list 			- Lista todos los listings disponibles"
	@echo "  make list X        - Lista solo listings del capítulo X
	@echo "  make all           - Compila todos los programas"
	@echo "  make clean         - Elimina compilaciones"
	@echo "  make help         	- Muestra esta ayuda"
	@echo "========================================="

# =============================================================================

# Prevenir eliminación de archivos intermedios
.PRECIOUS: $(BIN_DIR)/%.o