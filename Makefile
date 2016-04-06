OBJ=src/main
SRC=$(OBJ).md
PDF=$(OBJ).pdf
TEX=$(OBJ).tex

FLAGS = --listings --chapters --filter pandoc-eqnos
SECS := $(patsubst %.md,%.tex,$(wildcard src/*.md))

all: $(SECS)
	pandoc $(FLAGS) --standalone -o $(TEX) $(SRC)
	rubber --module=biber --pdf $(OBJ)

%.tex : %.md
	pandoc $(FLAGS) $< -o $@

preview:
	qlmanage -p $(PDF) &> /dev/null

clean:
	find . -type f -name '*.tex' -delete
	find . -type f -name '*.aux' -delete
	find . -type f -maxdepth 1 -name 'main*' -delete
