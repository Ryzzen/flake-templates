TARGET 			:= app
TARGET_HEX  ?= $(TARGET).hex
TARGET_BIN  ?= $(TARGET).bin

SRC_DIRS			:= src
INC_DIRS 			:= $(shell find $(SRC_DIRS) -type d)
BUILD_DIR			:= build

INC_FLAGS := $(addprefix -I,$(INC_DIRS))
INC_FLAGS += -lmath
INC_FLAGS += $(shell pkg-config --cflags --libs gio-2.0)

AS			?= clang
CC			?= clang
CXX			?= clang++
OBJCOPY ?= objcopy

CFLAGS = $(INC_FLAGS) \
		-Wall \
    -Wextra \
		-D_REENTRANT

CFLAGS_DEBUG := -g3 \
    -O \
    -DDEBUG

CFLAGS_RELEASE := -O2 \
    -march=native \
    -mtune=native \
    -ftree-vectorize

EXE		:= $(BUILD_DIR)/$(TARGET)
SRCS	:= $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.S)
OBJS	:= $(SRCS:%=$(BUILD_DIR)/%.o)

all: debug

debug: CFLAGS += $(CFLAGS_DEBUG)
debug: $(EXE)

release: CFLAGS += $(CFLAGS_RELEASE)
release: $(EXE)

$(EXE): $(OBJS)
	$(CC) $(OBJS) -o $@ $(CFLAGS)
	$(OBJCOPY) -Oihex   $@ $(BUILD_DIR)/$(TARGET_HEX)
	$(OBJCOPY) -Obinary $@ $(BUILD_DIR)/$(TARGET_BIN)

# assembly
$(BUILD_DIR)/%.S.o: %.S
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf build

rebuild: clean all

.PHONY: all clean rebuild debug release

