#!/bin/sh

PS2PDF = ps2pdf14
DVIPS = dvips
LATEX = latex
BIBTEX = bibtex
READER = acroread
PSVIEWER = gv

FILENAME = thesis
BIBFILE = thesisbib

TEXFILE = $(FILENAME).tex
DVIFILE = $(FILENAME).dvi
PSFILE = $(FILENAME).ps
PDFFILE = $(FILENAME).pdf

CLEANFILES = *.aux *.bbl *.dvi *.ps *.pdf *.lot *.lof *~ *.toc *.log *.backup \
	*.cb *.blg

TEX = thesis.tex title.tex acknowledgements.tex abstract.tex zusammefassung.tex \
        introduction.tex chapter1.tex chapter2.tex conclusion.tex futurework.tex \
        appendix.tex

DVIS = thesis.dvi title.dvi acknowledgements.dvi abstract.dvi zusammefassung.dvi \
	introduction.dvi chapter1.dvi chapter2.dvi conclusion.dvi futurework.dvi \
	appendix.dvi

PS = thesis.ps title.ps acknowledgements.ps abstract.ps zusammefassung.ps \
	introduction.ps chapter1.ps chapter2.ps conclusion.ps futurework.ps \
	appendix.ps

GOALS = $(PSFILE)

all: clean $(GOALS)

%.dvi: %.tex
	$(LATEX) $<
	$(BIBTEX) $(FILENAME)
	$(LATEX) $<
	$(LATEX) $<
	$(LATEX) $<

%.ps: %.dvi
	$(DVIPS) $< -o $@
	$(PSVIEWER) $(PSFILE)

%.pdf: %.ps
	$(PS2PDF) $(PSFILE) $(PDFFILE)
	$(READER) $(PDFILE)

clean:
	echo "removing files"
	-rm -f $(CLEANFILES)

.PHONY: clean
