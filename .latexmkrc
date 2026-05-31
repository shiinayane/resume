# Build with XeLaTeX (required for fontspec / bundled OTF fonts).
# Usage: latexmk            (builds resume.tex -> resume.pdf, reruns as needed)
#        latexmk -c         (clean aux files, keep the PDF)
$pdf_mode = 5;          # 5 = xelatex
$xelatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';
@default_files = ('resume.tex');
