# .latexmkrc configuration file
# Purpose: Configure latexmk to use lualatex and auto-detect bibtex/biber
# Author: Agni Datta
# Date: 2025-08-14 23:52

# Use lualatex as the default LaTeX engine
$pdflatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# Enable shell escape (if you use minted, gnuplot, etc.)
$latex = $pdflatex;  # consistency
$latex_silent = $pdflatex;  # for silent runs

# Allow shell escape — be cautious with this in shared environments
$pdflatex = 'lualatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
