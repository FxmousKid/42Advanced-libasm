# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/04 18:49:10 by inazaria          #+#    #+#              #
#    Updated: 2025/06/24 18:56:58 by inazaria         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# <><><><><><><> Directories & Files <><><><><><><><><><><><><><><><><><><>

SRC_DIR      := ./src/
BUILD_DIR    := ./build/
INC_DIR      := ./includes/

C_TEST_FILES_NAMES = tests/main.c 
C_TEST_FILES_NAMES += tests/ft_write.c
C_TEST_FILES_NAMES += tests/ft_strlen.c
C_TEST_FILES_NAMES += tests/ft_strcmp.c
C_TEST_FILES_NAMES += tests/ft_read.c
C_TEST_FILES_NAMES += tests/ft_strcpy.c
C_TEST_FILES_NAMES += tests/ft_strdup.c

C_BONUS_TEST_FILES_NAMES = tests_bonus/main_bonus.c 
C_BONUS_TEST_FILES_NAMES += tests_bonus/ft_list_size_bonus.c 
C_BONUS_TEST_FILES_NAMES += tests_bonus/ft_list_remove_if_bonus.c 
C_BONUS_TEST_FILES_NAMES += tests_bonus/ft_list_push_front_bonus.c 

ASM_SRC_FILES_NAMES = asm/ft_strlen.s
ASM_SRC_FILES_NAMES += asm/ft_write.s
ASM_SRC_FILES_NAMES += asm/ft_strcmp.s
ASM_SRC_FILES_NAMES += asm/ft_read.s
ASM_SRC_FILES_NAMES += asm/ft_strcpy.s
ASM_SRC_FILES_NAMES += asm/ft_strdup.s

ASM_BONUS_SRC_FILES_NAMES = asm_bonus/ft_list_size_bonus.s
ASM_BONUS_SRC_FILES_NAMES += asm_bonus/ft_list_push_front.s
ASM_BONUS_SRC_FILES_NAMES += asm_bonus/ft_list_remove_if_bonus.s

# Mandatory .s and .c files
ASM_SRC_FILES := $(addprefix $(SRC_DIR), $(ASM_SRC_FILES_NAMES))
C_TEST_FILES  := $(addprefix $(SRC_DIR), $(C_TEST_FILES_NAMES))

# Bonus .s and .c files
C_BONUS_TEST_FILES := $(addprefix $(SRC_DIR), $(C_BONUS_TEST_FILES_NAMES))
ASM_BONUS_SRC_FILES := $(addprefix $(SRC_DIR), $(ASM_BONUS_SRC_FILES_NAMES))

# Mandatory .o for .s and .c files 
ASM_OBJ_FILES 	:= $(patsubst $(SRC_DIR)%.s, $(BUILD_DIR)%.o, $(ASM_SRC_FILES))
C_OBJ_FILES 	:= $(patsubst $(SRC_DIR)%.c, $(BUILD_DIR)%.o, $(C_TEST_FILES))

# Bonus .o for .s and .c files
ASM_BONUS_OBJ_FILES   := $(patsubst $(SRC_DIR)%.s, $(BUILD_DIR)%.o, $(ASM_BONUS_SRC_FILES))
C_BONUS_OBJ_FILES 	  := $(patsubst $(SRC_DIR)%.c, $(BUILD_DIR)%.o, $(C_BONUS_TEST_FILES))

# <><><><><><><> Build Artifacts <><><><><><><><><><><><><><><><><><><>
NAME 	 	:= libasm.a          
NAME_BONUS  := libasm_bonus.a
TEST 	 	:= libasm_tester            
TEST_BONUS  := libasm_bonus_tester

# <><><><><><><> Flags <><><><><><><><><><><><><><><><><><>
NASM          := nasm
NASM_CFLAGS   := -f elf64 -g
CC            := cc
CC_CFLAGS     := -Wall -Wextra -Werror -I $(INC_DIR) -g3
CC_LFLAGS	  :=

# <><><><><><><> print helpers <><><><><><><><><><><><><><><><>
MKDIR   := mkdir -p
RM_RF   := rm -rf
ECHO    := echo -e
AR	 	:= ar rcs

BLUE  := $(shell echo -e "\033[34m")
BROWN := $(shell echo -e "\033[33m")
GREEN := $(shell echo -e "\033[32m")
RED   := $(shell echo -e "\033[31m")
NC    := $(shell echo -e "\033[0m")

# <><><><><><><> Build Rules <><><><><><><><><><><><><><><><><><><><>

# Custom .s -> .o rule
$(BUILD_DIR)%.o : $(SRC_DIR)%.s
	@$(MKDIR) $(dir $@)
	@$(ECHO) "$(BLUE)[CMP] Assembling $< ...$(NC)"
	@$(NASM) $(NASM_CFLAGS) $< -o $@

# Custom .c -> .o rule
$(BUILD_DIR)%.o : $(SRC_DIR)%.c
	@$(MKDIR) $(dir $@)
	@$(ECHO) "$(BLUE)[CMP] Compiling $< ...$(NC)"
	@$(CC) $(CC_CFLAGS) -c $< -o $@

# Default target – build library and test binary
all: $(NAME) $(TEST) 

bonus: $(NAME) $(NAME_BONUS) $(TEST_BONUS)

re: fclean all

re_bonus : fclean bonus

# Static Mandatory library from all object files
$(NAME): $(ASM_OBJ_FILES)
	@$(ECHO) "$(BROWN)[ARX] Archiving objects into $@ ...$(NC)"
	@$(AR) $@ $(ASM_OBJ_FILES)
	@$(ECHO) "$(GREEN)[ARX] Static library built successfully.$(NC)"

# Static Bonus library from all object files
$(NAME_BONUS): $(ASM_BONUS_OBJ_FILES)
	@$(ECHO) "$(BROWN)[ARX] Archiving Bonus objects into $@ ...$(NC)"
	@$(AR) $@ $(ASM_BONUS_OBJ_FILES)
	@$(ECHO) "$(GREEN)[ARX] Static library built successfully.$(NC)"

# Test executable, links against libasm.a in current dir
$(TEST): $(NAME) $(C_OBJ_FILES)
	@$(ECHO) "$(BROWN)[LNK] Building test executable ...$(NC)"
	@$(CC) $(CC_LFLAGS) $(C_OBJ_FILES) -L. $(NAME) -lasm -o $@
	@$(ECHO) "$(GREEN)[LNK] Executable built successfully.$(NC)"

# Test executable, links against libasm.a in current dir
$(TEST_BONUS): $(NAME_BONUS) $(C_BONUS_OBJ_FILES)
	@$(ECHO) "$(BROWN)[LNK] Building bonus test executable ...$(NC)"
	@$(CC) $(CC_LFLAGS) $(C_BONUS_OBJ_FILES) -L. $(NAME) $(NAME_BONUS) -lasm -o $@
	@$(ECHO) "$(GREEN)[LNK] Bonus Executable built successfully.$(NC)"

# Handy rule to force relinking
link: $(NAME)
	@$(ECHO) "$(BROWN)[LNK] Building test executable ...$(NC)"
	@$(CC) $(CC_LFLAGS) $(C_OBJ_FILES) -L. -lasm -o $(TEST)
	@$(ECHO) "$(GREEN)[LNK] Executable built successfully.$(NC)"

# Handy rule to force relinking
link_bonus: $(NAME_BONUS)
	@$(ECHO) "$(BROWN)[LNK] Building Bonus test executable ...$(NC)"
	@$(CC) $(CC_LFLAGS) $(C_BONUS_OBJ_FILES) -L. $(NAME) $(NAME_BONUS) -lasm -o $(TEST_BONUS)
	@$(ECHO) "$(GREEN)[LNK] Bonus Executable built successfully.$(NC)"


# Convenience phony targets
clean:
	@$(ECHO) "$(BROWN)[CLN] Removing object files ...$(NC)"
	@$(RM_RF) $(BUILD_DIR)
	@$(ECHO) "$(GREEN)[CLN] Clean complete.$(NC)"

fclean: clean
	@$(ECHO) "$(BROWN)[CLN] Removing library and test executable ...$(NC)"
	@$(RM_RF) $(NAME) $(NAME_BONUS) $(TEST) $(TEST_BONUS)
	@$(ECHO) "$(GREEN)[CLN] Full clean complete.$(NC)"

.PHONY: all clean fclean re link link_bonus bonus re_bonus
.DEFAULT_GOAL := all
