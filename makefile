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
# Librerías que se van a enlazar
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
# ==========================CAPITULO 3=========================================

# LISTING 3.1
LISTING_3_1_SOURCES = $(SRC_DIR)/capitulo3/3.1/print-pid.c
LISTING_3_1_TARGET = print-pid
LISTING_3_1_COMPILER = CC
LISTING_3_1_TYPE = EXECUTABLE

# LISTING 3.2
LISTING_3_2_SOURCES = $(SRC_DIR)/capitulo3/3.2/system.c
LISTING_3_2_TARGET = system
LISTING_3_2_COMPILER = CC
LISTING_3_2_TYPE = EXECUTABLE

# LISTING 3.3
LISTING_3_3_SOURCES = $(SRC_DIR)/capitulo3/3.3/fork.c
LISTING_3_3_TARGET = fork
LISTING_3_3_COMPILER = CC
LISTING_3_3_TYPE = EXECUTABLE

# LISTING 3.4
LISTING_3_4_SOURCES = $(SRC_DIR)/capitulo3/3.4/fork-exec.c
LISTING_3_4_TARGET = fork-exec
LISTING_3_4_COMPILER = CC
LISTING_3_4_TYPE = EXECUTABLE

# LISTING 3.5
LISTING_3_5_SOURCES = $(SRC_DIR)/capitulo3/3.5/sigusr1.c
LISTING_3_5_TARGET = sigusr1
LISTING_3_5_COMPILER = CC
LISTING_3_5_TYPE = EXECUTABLE

# LISTING 3.6
LISTING_3_6_SOURCES = $(SRC_DIR)/capitulo3/3.6/zombie.c
LISTING_3_6_TARGET = make-zombie
LISTING_3_6_COMPILER = CC
LISTING_3_6_TYPE = EXECUTABLE

# LISTING 3.7
LISTING_3_7_SOURCES = $(SRC_DIR)/capitulo3/3.7/sigchld.c
LISTING_3_7_TARGET = sigchld
LISTING_3_7_COMPILER = CC
LISTING_3_7_TYPE = EXECUTABLE

# =============================================================================
# ==========================CAPITULO 4=========================================

# LISTING 4.1
LISTING_4_1_SOURCES = $(SRC_DIR)/capitulo4/4.1/thread-create.c
LISTING_4_1_TARGET = thread-create
LISTING_4_1_COMPILER = CC
LISTING_4_1_LIBS = -lpthread
LISTING_4_1_TYPE = EXECUTABLE

# LISTING 4.2
LISTING_4_2_SOURCES = $(SRC_DIR)/capitulo4/4.2/thread-create2.c
LISTING_4_2_TARGET = thread-create2
LISTING_4_2_COMPILER = CC
LISTING_4_2_LIBS = -lpthread
LISTING_4_2_TYPE = EXECUTABLE

# LISTING 4.3
LISTING_4_3_SOURCES = $(SRC_DIR)/capitulo4/4.3/thread-create2.c
LISTING_4_3_TARGET = thread-create3
LISTING_4_3_COMPILER = CC
LISTING_4_3_LIBS = -lpthread
LISTING_4_3_TYPE = EXECUTABLE

# LISTING 4.4
LISTING_4_4_SOURCES = $(SRC_DIR)/capitulo4/4.4/primes.c
LISTING_4_4_TARGET = primes
LISTING_4_4_COMPILER = CC
LISTING_4_4_LIBS = -lpthread
LISTING_4_4_TYPE = EXECUTABLE

# LISTING 4.5
LISTING_4_5_SOURCES = $(SRC_DIR)/capitulo4/4.5/detached.c
LISTING_4_5_TARGET = detached
LISTING_4_5_COMPILER = CC
LISTING_4_5_LIBS = -lpthread
LISTING_4_5_TYPE = EXECUTABLE

# LISTING 4.6
LISTING_4_6_SOURCES = $(SRC_DIR)/capitulo4/4.6/critical-section.c
LISTING_4_6_TARGET = critical-section
LISTING_4_6_COMPILER = CC
LISTING_4_6_LIBS = -lpthread
LISTING_4_6_TYPE = EXECUTABLE

# LISTING 4.7
LISTING_4_7_SOURCES = $(SRC_DIR)/capitulo4/4.7/tsd.c
LISTING_4_7_TARGET = tsd
LISTING_4_7_COMPILER = CC
LISTING_4_7_LIBS = -lpthread
LISTING_4_7_TYPE = EXECUTABLE

# LISTING 4.8
LISTING_4_8_SOURCES = $(SRC_DIR)/capitulo4/4.8/cleanup.c
LISTING_4_8_TARGET = cleanup
LISTING_4_8_COMPILER = CC
LISTING_4_8_LIBS = -lpthread
LISTING_4_8_TYPE = EXECUTABLE

# LISTING 4.9
LISTING_4_9_SOURCES = $(SRC_DIR)/capitulo4/4.9/cxx-exit.cpp
LISTING_4_9_TARGET = cxx-exit
LISTING_4_9_COMPILER = CXX
LISTING_4_9_LIBS = -lpthread
LISTING_4_9_TYPE = EXECUTABLE

# LISTING 4.10
LISTING_4_10_SOURCES = $(SRC_DIR)/capitulo4/4.10/job-queue1.c
LISTING_4_10_TARGET = job-queue1
LISTING_4_10_COMPILER = CC
LISTING_4_10_LIBS = -lpthread
LISTING_4_10_TYPE = EXECUTABLE

# LISTING 4.11
LISTING_4_11_SOURCES = $(SRC_DIR)/capitulo4/4.11/job-queue2.c
LISTING_4_11_TARGET = job-queue2
LISTING_4_11_COMPILER = CC
LISTING_4_11_LIBS = -lpthread
LISTING_4_11_TYPE = EXECUTABLE

# LISTING 4.12
LISTING_4_12_SOURCES = $(SRC_DIR)/capitulo4/4.12/job-queue3.c
LISTING_4_12_TARGET = job-queue3
LISTING_4_12_COMPILER = CC
LISTING_4_12_LIBS = -lpthread
LISTING_4_12_TYPE = EXECUTABLE

# LISTING 4.13
LISTING_4_13_SOURCES = $(SRC_DIR)/capitulo4/4.13/spin-condvar.c
LISTING_4_13_TARGET = spin-condvar
LISTING_4_13_COMPILER = CC
LISTING_4_13_LIBS = -lpthread
LISTING_4_13_TYPE = EXECUTABLE

# LISTING 4.14
LISTING_4_14_SOURCES = $(SRC_DIR)/capitulo4/4.14/condvar.c
LISTING_4_14_TARGET = condvar
LISTING_4_14_COMPILER = CC
LISTING_4_14_LIBS = -lpthread
LISTING_4_14_TYPE = EXECUTABLE

# LISTING 4.15
LISTING_4_15_SOURCES = $(SRC_DIR)/capitulo4/4.15/thread-pid.c
LISTING_4_15_TARGET = thread-pid
LISTING_4_15_COMPILER = CC
LISTING_4_15_LIBS = -lpthread
LISTING_4_15_TYPE = EXECUTABLE

# =============================================================================
# ==========================CAPITULO 5=========================================

# LISTING 5.1
LISTING_5_1_SOURCES = $(SRC_DIR)/capitulo5/5.1/shm.c
LISTING_5_1_TARGET = shm
LISTING_5_1_COMPILER = CC
LISTING_5_1_TYPE = EXECUTABLE

# LISTING 5.2
LISTING_5_2_SOURCES = $(SRC_DIR)/capitulo5/5.2/sem_all_deall.c
LISTING_5_2_TARGET = sem_all_deall
LISTING_5_2_COMPILER = CC
LISTING_5_2_TYPE = EXECUTABLE

# LISTING 5.3
LISTING_5_3_SOURCES = $(SRC_DIR)/capitulo5/5.3/sem_init.c
LISTING_5_3_TARGET = sem_init
LISTING_5_3_COMPILER = CC
LISTING_5_3_TYPE = EXECUTABLE

# LISTING 5.4
LISTING_5_4_SOURCES = $(SRC_DIR)/capitulo5/5.4/sem_pv.c
LISTING_5_4_TARGET = sem_pv
LISTING_5_4_COMPILER = CC
LISTING_5_4_TYPE = EXECUTABLE

# LISTING 5.5
LISTING_5_5_SOURCES = $(SRC_DIR)/capitulo5/5.5/mmap-write.c
LISTING_5_5_TARGET = mmap-write
LISTING_5_5_COMPILER = CC
LISTING_5_5_TYPE = EXECUTABLE

# LISTING 5.6
LISTING_5_6_SOURCES = $(SRC_DIR)/capitulo5/5.6/mmap-read.c
LISTING_5_6_TARGET = mmap-read
LISTING_5_6_COMPILER = CC
LISTING_5_6_TYPE = EXECUTABLE

# LISTING 5.7
LISTING_5_7_SOURCES = $(SRC_DIR)/capitulo5/5.7/pipe.c
LISTING_5_7_TARGET = pipe
LISTING_5_7_COMPILER = CC
LISTING_5_7_TYPE = EXECUTABLE

# LISTING 5.8
LISTING_5_8_SOURCES = $(SRC_DIR)/capitulo5/5.8/dup2.c
LISTING_5_8_TARGET = dup2
LISTING_5_8_COMPILER = CC
LISTING_5_8_TYPE = EXECUTABLE

# LISTING 5.9
LISTING_5_9_SOURCES = $(SRC_DIR)/capitulo5/5.9/popen.c
LISTING_5_9_TARGET = popen
LISTING_5_9_COMPILER = CC
LISTING_5_9_TYPE = EXECUTABLE

# LISTING 5.10
LISTING_5_10_SOURCES = $(SRC_DIR)/capitulo5/5.10/socket-server.c
LISTING_5_10_TARGET = socket-server
LISTING_5_10_COMPILER = CC
LISTING_5_10_TYPE = EXECUTABLE

# LISTING 5.11
LISTING_5_11_SOURCES = $(SRC_DIR)/capitulo5/5.11/socket-client.c
LISTING_5_11_TARGET = socket-client
LISTING_5_11_COMPILER = CC
LISTING_5_11_TYPE = EXECUTABLE

# LISTING 5.12
LISTING_5_12_SOURCES = $(SRC_DIR)/capitulo5/5.12/socket-inet.c
LISTING_5_12_TARGET = socket-inet
LISTING_5_12_COMPILER = CC
LISTING_5_12_TYPE = EXECUTABLE

# =============================================================================

ALL_TARGETS := listing-1.1 listing-1.2 listing-1.LINK-1.1-1.2 listing-2.1 
ALL_TARGETS += listing-2.2 listing-2.3 listing-2.4 listing-2.5 listing-2.6
ALL_TARGETS += listing-2.7 listing-2.8 listing-2.9 listing-3.1 listing-3.2
ALL_TARGETS += listing-3.3 listing-3.4 listing-3.5 listing-3.6 listing-3.7
ALL_TARGETS += listing-4.1 listing-4.2 listing-4.3 listing-4.4 listing-4.5
ALL_TARGETS += listing-4.6 listing-4.7 listing-4.8 listing-4.9 listing-4.10
ALL_TARGETS += listing-4.11 listing-4.12 listing-4.13 listing-4.14
ALL_TARGETS += listing-4.15 listing-5.1 listing-5.2 listing-5.3 listing-5.4
ALL_TARGETS += listing-5.5 listing-5.6 listing-5.7 listing-5.8 listing-5.9
ALL_TARGETS += listing-5.10 listing-5.11 listing-5.12

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

# ===================================
# CAPITULO 3
# ===================================
# Listing 3.1
$(eval $(call make_listing_rule,3,1))
# Listing 3.2
$(eval $(call make_listing_rule,3,2))
# Listing 3.3
$(eval $(call make_listing_rule,3,3))
# Listing 3.4
$(eval $(call make_listing_rule,3,4))
# Listing 3.5
$(eval $(call make_listing_rule,3,5))
# Listing 3.6
$(eval $(call make_listing_rule,3,6))
# Listing 3.7
$(eval $(call make_listing_rule,3,7))
# Listing 3.8
$(eval $(call make_listing_rule,3,8))
# Listing 3.9
$(eval $(call make_listing_rule,3,9))
# Listing 3.10
$(eval $(call make_listing_rule,3,10))

# ===================================
# CAPITULO 4
# ===================================
# Listing 4.1
$(eval $(call make_listing_rule,4,1))
# Listing 4.2
$(eval $(call make_listing_rule,4,2))
# Listing 4.3
$(eval $(call make_listing_rule,4,3))
# Listing 4.4
$(eval $(call make_listing_rule,4,4))
# Listing 4.5
$(eval $(call make_listing_rule,4,5))
# Listing 4.6
$(eval $(call make_listing_rule,4,6))
# Listing 4.7
$(eval $(call make_listing_rule,4,7))
# Listing 4.8
$(eval $(call make_listing_rule,4,8))
# Listing 4.9
$(eval $(call make_listing_rule,4,9))
# Listing 4.10
$(eval $(call make_listing_rule,4,10))
# Listing 4.11
$(eval $(call make_listing_rule,4,11))
# Listing 4.12
$(eval $(call make_listing_rule,4,12))
# Listing 4.13
$(eval $(call make_listing_rule,4,13))
# Listing 4.14
$(eval $(call make_listing_rule,4,14))
# listing 4.15
$(eval $(call make_listing_rule,4,15))

# ===================================
# CAPITULO 5
# ===================================
# Listing 5.1
$(eval $(call make_listing_rule,5,1))
# Listing 5.2
$(eval $(call make_listing_rule,5,2))
# Listing 5.3
$(eval $(call make_listing_rule,5,3))
# Listing 5.4
$(eval $(call make_listing_rule,5,4))
# Listing 5.5
$(eval $(call make_listing_rule,5,5))
# Listing 5.6
$(eval $(call make_listing_rule,5,6))
# Listing 5.7
$(eval $(call make_listing_rule,5,7))
# Listing 5.8
$(eval $(call make_listing_rule,5,8))
# Listing 5.9
$(eval $(call make_listing_rule,5,9))
# Listing 5.10
$(eval $(call make_listing_rule,5,10))
# Listing 5.11
$(eval $(call make_listing_rule,5,11))
# Listing 5.12
$(eval $(call make_listing_rule,5,12))

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