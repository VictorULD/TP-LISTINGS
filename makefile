
# Compilador para archivos C
CC = gcc
# Compilador para archivos C++
CXX = g++

# Flags de compilación para C
CFLAGS = -Wall -g -w
# Flags de compilación para C++ 
CXXFLAGS = -Wall -g -w
# Librerías que se van a enlazar
LDFLAGS = -lm 


# Directorio donde están los archivos fuente
SRC_DIR = src
# Directorio donde van los ejecutables compilados
BIN_DIR = bin

# =============================================================================
# Archivos fuente del listing
# Nombre del ejecutable
# Tipo de compilador
# =============================================================================


# LISTING 1.1
LISTING_1_1_SOURCES = $(SRC_DIR)/capitulo1/1.1/main.c $(SRC_DIR)/capitulo1/1.3/reciprocal.hpp

LISTING_1_1_TARGET = main

LISTING_1_1_COMPILER = CC

# LISTING 1.2 
LISTING_1_2_SOURCES = $(SRC_DIR)/capitulo1/1.2/reciprocal.cpp $(SRC_DIR)/capitulo1/1.3/reciprocal.hpp

LISTING_1_2_TARGET = reciprocal

LISTING_1_2_COMPILER = CXX

# LINK LISTING  1.1 y 1.2
LISTING_LINK_SOURCES = $(BIN_DIR)/capitulo1/1.1/ $(BIN_DIR)/capitulo1/1.2/

LISTING_LINK_TARGET = reciprocal_x

LISTING_LINK_COMPILER = CXX

# =============================================================================

ALL_TARGETS :=

# =============================================================================

define make_listing_rule

# Solo crear regla si existen archivos fuente definidos
ifdef LISTING_$(1)_$(2)_SOURCES

# Determinar objetos intermedios (.o) basados en archivos fuente
LISTING_$(1)_$(2)_COMPILABLE = $$(filter %.c %.cpp,$$(LISTING_$(1)_$(2)_SOURCES))
LISTING_$(1)_$(2)_OBJECTS = $$(LISTING_$(1)_$(2)_COMPILABLE:$(SRC_DIR)/%.c=$(BIN_DIR)/%.o)
LISTING_$(1)_$(2)_OBJECTS := $$(LISTING_$(1)_$(2)_OBJECTS:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%.o)

# Path completo del ejecutable final
LISTING_$(1)_$(2)_FULL_TARGET = $(BIN_DIR)/capitulo$(1)/$(1).$(2)/$$(LISTING_$(1)_$(2)_TARGET)

# Agregar a la lista de todos los targets
ALL_TARGETS += $$(LISTING_$(1)_$(2)_FULL_TARGET)

# Crear el target específico para este listing
.PHONY: listing-$(1).$(2)
listing-$(1).$(2): $$(LISTING_$(1)_$(2)_FULL_TARGET)

# Regla para enlazar el ejecutable final
$$(LISTING_$(1)_$(2)_FULL_TARGET): $$(LISTING_$(1)_$(2)_OBJECTS)
	@echo "Compilando listing $(1).$(2)..."
	@mkdir -p $$(dir $$@)
	@echo "✓ Listing $(1).$(2) compilado exitosamente -> $$@"

endif

endef

# =============================================================================

# Función especial para LISTING LINK
define make_link_rule

# Solo crear regla si existen archivos fuente definidos para LINK
ifdef LISTING_$(1)_SOURCES

# Determinar objetos intermedios (.o) basados en archivos fuente
LISTING_$(1)_OBJECTS = $(LISTING_$(1)_SOURCES:$(SRC_DIR)/%.c=$(BIN_DIR)/%.o)
LISTING_$(1)_OBJECTS := $(LISTING_$(1)_OBJECTS:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%.o)
# Filtrar archivos .hpp que no generan objetos
LISTING_$(1)_OBJECTS := $(filter %.o,$(LISTING_$(1)_OBJECTS))

# Path completo del ejecutable final
LISTING_$(1)_FULL_TARGET = $(BIN_DIR)/capitulo1/$(LISTING_$(1)_TARGET)

# Agregar a la lista de todos los targets
ALL_TARGETS += $(LISTING_$(1)_FULL_TARGET)

# Crear el target específico para este listing link
.PHONY: listing-$(1)
listing-$(1): $(LISTING_$(1)_FULL_TARGET)

# Regla para enlazar el ejecutable final (CON LINKEO REAL para programa funcional)
$(LISTING_$(1)_FULL_TARGET): $(LISTING_$(1)_OBJECTS)
	@echo "Enlazando listing $(1)..."
	@echo "Archivos objeto: $(LISTING_$(1)_OBJECTS)"
	@mkdir -p $(dir $@)
	@$(if $(filter CXX,$(LISTING_$(1)_COMPILER)),$(CXX),$(CC)) $^ -o $@ $(LDFLAGS)
	@echo "✓ Listing $(1) compilado y enlazado exitosamente -> $@"

endif

endef

# =============================================================================


# Llamar a la función para cada listing definido

# CAPITULO 1
$(eval $(call make_listing_rule,1,1))
$(eval $(call make_listing_rule,1,2))

# Debug: Verificar que LISTING_LINK_SOURCES esté definido
$(info LISTING_LINK_SOURCES = $(LISTING_LINK_SOURCES))

# Llamar a la función especial para LISTING LINK
$(eval $(call make_link_rule,LINK))

# Debug: Verificar que se creó el target
$(info ALL_TARGETS = $(ALL_TARGETS))

# CAPITULO 2

# =============================================================================
# REGLA MANUAL PARA LISTING-LINK (como backup)
# =============================================================================

# Objetos específicos para el programa completo
LINK_OBJECTS = $(BIN_DIR)/capitulo1/1.1/main.o $(BIN_DIR)/capitulo1/1.2/reciprocal.o

# Ejecutable del programa completo
LINK_EXECUTABLE = $(BIN_DIR)/capitulo1/programa_completo_manual

.PHONY: listing-LINK-manual
listing-LINK-manual: $(LINK_EXECUTABLE)

$(LINK_EXECUTABLE): $(LINK_OBJECTS)
	@echo "Enlazando programa completo (manual)..."
	@echo "Archivos objeto: $(LINK_OBJECTS)"
	@mkdir -p $(dir $@)
	$(CXX) $^ -o $@ $(LDFLAGS)
	@echo "✓ Programa completo compilado exitosamente -> $@"

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


.PHONY: all
all: $(ALL_TARGETS)
	@echo "========================================="
	@echo "✓ COMPILACIÓN COMPLETADA"
	@echo "Total de programas compilados: $(words $(ALL_TARGETS))"
	@echo "========================================="


.PHONY: clean
clean:
	@echo "Limpiando archivos compilados..."
	@rm -rf $(BIN_DIR)/*/*
	@echo "✓ Limpieza completada!"


# =============================================================================

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


.PHONY: help  
help: info

# =============================================================================

# Prevenir eliminación de archivos intermedios
.PRECIOUS: $(BIN_DIR)/%.o