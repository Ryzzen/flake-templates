TARGET 			:= app
TARGET_HEX  ?= $(TARGET).hex
TARGET_BIN  ?= $(TARGET).bin

DEBUG ?= 1
BUILD_DIR			?= build
SRC_DIRS			?= src
INC_DIRS 			:= $(shell find $(SRC_DIRS) -type d)

AS			?= clang
CC			?= clang
CXX			?= clang++
OBJCOPY ?= objcopy

INC_FLAGS := $(addprefix -I,$(INC_DIRS))
INC_FLAGS += -lmath
FLAGS = -Wall \
    -Wextra
FLAGS_DEBUG := -g3 \
    -O
FLAGS_RELEASE := -O2 \
    -march=native \
    -mtune=native \
    -ftree-vectorize

ASFLAGS ?= $(FLAGS) -x assembler $(INC_FLAGS) -MMD -MP
CFLAGS ?=  $(FLAGS) $(INC_FLAGS) -std=gnu17 -MMD -MP
CPPFLAGS ?=  $(FLAGS) $(INC_FLAGS) -std=gnu17 -MMD -MP
LDFLAGS ?= $(FLAGS) #--specs=nano.specs --specs=nosys.specs

ifeq ($(DEBUG), 1)
    FLAGS += $(FLAGS_DEBUG) -DDEBUG
else
    FLAGS += $(FLAGS_RELEASE) -DRELEASE
endif

SRCS	:= $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.S)
OBJS	:= $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

$(BUILD_DIR)/$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)
	$(OBJCOPY) -Oihex   $@ $(BUILD_DIR)/$(TARGET_HEX)
	$(OBJCOPY) -Obinary $@ $(BUILD_DIR)/$(TARGET_BIN)

# assembly
$(BUILD_DIR)/%.S.o: %.S
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)

.PHONY: clean 

-include $(DEPS)
