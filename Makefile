###############################################################################
#  Makefile — dual-format LaTeX build
#
#  TARGETS
#    make pdf       Build the full article / eprint version.
#                   Reads main.tex as-is (flags: \Submissionfalse \Eprinttrue).
#                   Output: main.pdf
#
#    make llncs     Build the Springer LLNCS / conference submission version.
#                   Does NOT touch main.tex on disk — sed flips \Submissionfalse
#                   to \Submissiontrue in-memory and pipes the result into
#                   latexmk via stdin ("-").  The -jobname flag redirects all
#                   output (pdf, aux, log, …) to main-llncs.* so the two
#                   builds never clobber each other.
#                   Output: main-llncs.pdf
#
#    make all       Build both targets above in sequence.
#
#    make clean     Remove latexmk's intermediate files (.aux .log .bbl …)
#                   for both jobs.  PDFs are kept.
#
#    make distclean Remove everything: intermediate files + both PDFs.
#
#  VARIABLES
#    MAIN     — base name of the root .tex file (no extension).  Change this
#               if you rename main.tex.
#    LATEXMK  — latexmk binary; override if yours lives elsewhere, e.g.
#               make pdf LATEXMK=/usr/local/texlive/bin/latexmk
###############################################################################

MAIN    = main
LATEXMK = latexmk

.PHONY: pdf llncs all clean distclean

# Full article / eprint build
pdf:
	$(LATEXMK) -pdf $(MAIN).tex

# LLNCS submission build — flip \Submissionfalse → \Submissiontrue on the fly
llncs:
	sed 's/\\Submissionfalse/\\Submissiontrue/' $(MAIN).tex \
	  | $(LATEXMK) -pdf -jobname=$(MAIN)-llncs -

# Build both
all: pdf llncs

# Remove intermediate files, keep PDFs
clean:
	$(LATEXMK) -c $(MAIN).tex
	$(LATEXMK) -c -jobname=$(MAIN)-llncs $(MAIN).tex

# Remove everything including PDFs
distclean:
	$(LATEXMK) -C $(MAIN).tex
	$(LATEXMK) -C -jobname=$(MAIN)-llncs $(MAIN).tex
	rm -f $(MAIN).pdf $(MAIN)-llncs.pdf
