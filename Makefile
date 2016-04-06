OBJ=src/report
SRC=$(OBJ).md
PDF=$(OBJ).pdf
TEX=$(OBJ).tex

SECS := $(patsubst %.md,%.tex,$(wildcard src/*.md))

all: $(SECS)
	pandoc --standalone -o $(TEX) $(SRC)
	rubber --module=biber --pdf $(OBJ)

%.tex : %.md
	pandoc $< -o $@

preview:
	qlmanage -p $(PDF) &> /dev/null

clean:
	find . -type f -name '*.tex' -delete
	find . -type f -name '*.aux' -delete
	find . -type f -maxdepth 1 -name 'report*' -delete
