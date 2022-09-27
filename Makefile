SRC   = src/types.f90 src/board.f90 src/iohandle.f90 src/main.f90
OBJ   = $(addsuffix .o,$(subst src/,bin/,$(basename $(SRC))))
OUT   = ./bin/ygttt

FC      = gfortran
F_VER   = f2003
F_FLAGS = -Wall -Wextra -Werror -pedantic -std=$(F_VER) -g
F_LIBS  = -I./M_ncurses/src/
F_LINK  = ./M_ncurses/src/*.o -lncurses 

compile: ./bin $(OBJ) $(SRC)
	$(FC) $(F_LIBS) $(F_FLAGS) -o $(OUT) $(OBJ) $(F_LINK)

bin/%.o: src/%.f90
	$(FC) $(F_LIBS) -c $< $(F_FLAGS) -o $@

./bin:
	mkdir -p bin

clean:
	rm -r ./bin/* ./*.mod

all:
	@echo compile, clean
