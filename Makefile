DIRS := $(shell ls -d */)
ASM_DIRS := $(patsubst %/,%,$(DIRS))
# Creates the TARGETS variable for holds the dir/binary makefile recipe.
$(foreach dir,$(ASM_DIRS),$(eval TARGETS += $(dir)/$(dir)))

# A template for defining recipes to build each ASM directory
# This requires that a directory exist and an assembly file, with the same
# name as the directory and a .asm extention, exists within it.
define ASM_DIR_RECIPE
$(target): $(target).o
	ld -o $(target) $(target).o
$(target).o:
	yasm -f elf64 -g dwarf2 -l $(target).lst $(target).asm -o $(target).o
endef

# Bash template for cleaning up build assembly directories.
define ASM_DIR_CLEAN
	rm -rf $(target)
	rm -rf $(target).lst
	rm -rf $(target).o
endef

.PHONY:
all: $(TARGETS)

$(foreach target,$(TARGETS),$(eval $(call ASM_DIR_RECIPE,$(target))))

.PHONY:
clean:
	$(foreach target,$(TARGETS),$(call ASM_DIR_CLEAN))