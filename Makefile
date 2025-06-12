# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/04 18:49:10 by inazaria          #+#    #+#              #
#    Updated: 2025/06/12 19:31:28 by inazaria         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#<><><><><><><> Files <><><><><><><><><><><><><><><><><><><>
SRC_DIR 	= ./src/
BUILD_DIR 	= ./build/

C_TEST_FILE := src/main.c

SRC_FILES_NAMES = ft_strlen.s
# SRC_FILES_NAMES +=  

# full paths to .s files
SRC_FILES = $(addprefix $(SRC_DIR), $(SRC_FILES_NAMES))

# .o files for compilation
OBJ_FILES = $(patsubst $(SRC_DIR)%.s, $(BUILD_DIR)%.o, $(SRC_FILES))

# Maybe to add .d files dependecy in NASM compilation

#<><><><><><><> Variables <><><><><><><><><><><><><><><><><>

NAME := libasm
NASM := nasm
CC := cc
CC_CFLAGS := 
CC_LFLAGS = -o $(NAME)
NASM_CFLAGS := -f elf64
NASM_LFLAGS := 

MKDIR := mkdir -p
RM_RF := rm -rf
ECHO  := echo -e

BLUE	:= $(shell echo -e "\033[34m") 
BROWN	:= $(shell echo -e "\033[33m")
GREEN	:= $(shell echo -e "\033[32m")
RED		:= $(shell echo -e "\033[31m")
NC		:= $(shell echo -e "\033[0m")

#<><><><><><><> Recipes <><><><><><><><><><><><><><><><><><>

$(BUILD_DIR)%.o : $(SRC_DIR)%.s
	@$(MKDIR) $(dir $@)
	@$(ECHO) "$(BLUE)[CMP] Compiling $<...$(NC)"
	@$(NASM) $(NASM_CFLAGS) $< -o $@

all: $(NAME)

re: clean all

$(NAME): $(OBJ_FILES)
	@$(ECHO) "$(BROWN)[LNK] Linking all .o files to test...$(NC)"
	@$(CC) $(CC_LFLAGS) $(C_TEST_FILE) $(OBJ_FILES)
	@$(ECHO) "$(GREEN)[LNK] Executable built successfully.$(NC)"

clean : 
	@$(ECHO) "$(BROWN)[CLN] Cleaning object and dependency files...$(NC)"
	@$(RM_RF) $(BUILD_DIR)
	@$(ECHO) "$(GREEN)[CLN] Clean complete.$(NC)"

fclean : 
	@$(ECHO) "$(BROWN)[CLN] Cleaning object, dependency files, and executable...$(NC)"
	@$(RM_RF) $(BUILD_DIR) $(NAME)
	@$(ECHO) "$(GREEN)[CLN] Clean complete.$(NC)"

.PHONY : all clean fclean re 
.DEFAULT_GOAL := all
