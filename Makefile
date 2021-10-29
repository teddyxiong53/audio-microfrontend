
MAKEFLAGS                       := -j $(shell nproc)
SRC_EXT                 := cc
OBJ_EXT                         := o
CC                                      := gcc
CXX := g++

SRC_DIR                         := ./
WORKING_DIR                     := ./build
BUILD_DIR                       := $(WORKING_DIR)/obj
BIN_DIR                         := $(WORKING_DIR)/bin
UI_DIR                          := ui

WARNINGS                        := -Wall

CXXFLAGS                          := -O0 -g $(WARNINGS) -fpermissive

# Add simulator define to allow modification of source
DEFINES                         :=

# Include simulator inc folder first so lv_conf.h from custom UI can be used instead
INC                             := -I./lib -I /usr/local/include/kissfft
LDFLAGS                         := -lkissfft-float
BIN                             := $(BIN_DIR)/test

COMPILE                         = $(CXX) $(CXXFLAGS) $(INC) $(DEFINES)

# Automatically include all source files
SRCS                            := $(shell find $(SRC_DIR) -type f -name '*.cc' -not -path '*/\.*')
SRCS := $(filter-out %_test.cc,$(SRCS))
SRCS := $(filter-out %_main.cc,$(SRCS))
OBJECTS                         := $(patsubst $(SRC_DIR)%,$(BUILD_DIR)/%,$(SRCS:.$(SRC_EXT)=.$(OBJ_EXT)))

all: default

$(BUILD_DIR)/%.$(OBJ_EXT): $(SRC_DIR)/%.$(SRC_EXT)
	@echo 'Building project file: $<'
	@mkdir -p $(dir $@)
	@$(COMPILE) -c -o "$@" "$<"

default: $(OBJECTS)
	@mkdir -p $(BIN_DIR)
	$(CXX) -o $(BIN) $(OBJECTS) $(LDFLAGS)

clean:
	rm -rf $(WORKING_DIR)