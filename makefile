PdfLaTeX := pdflatex
PdfCrop := pdfcrop
Biber := biber

DelCmd := del /s /q

CroppedSamples :=\
	Samples/FirstDoc-crop.pdf\
	Samples/FootnoteSample-crop.pdf\
	Samples/MarginparnoteSample-crop.pdf\
	Samples/Itemize-crop.pdf\
	Samples/Enumerate-crop.pdf\
	Samples/Description-crop.pdf\
	Samples/NestedItemize-crop.pdf\
	Samples/NestedEnumerate-crop.pdf\
	Samples/MathSample1-crop.pdf\
	Samples/MathSample2-crop.pdf\
	Samples/MathSample3-crop.pdf\
	Samples/Definition-crop.pdf\
	Samples/Theorem-crop.pdf\
	Samples/FlushLeft-crop.pdf\
	Samples/FlushRight-crop.pdf\
	Samples/CenteredText-crop.pdf\
	Samples/CommentSample-crop.pdf

.PHONY: clean cleanwork
.PRECIOUS: Samples/%-crop.pdf


AllLectures.pdf: AllLectures.tex $(CroppedSamples)
	$(PdfLaTeX) $<
	$(Biber) $(basename $<)
	$(PdfLaTeX) -interaction=batchmode $<
	$(PdfLaTeX) -interaction=batchmode $<


Samples/%-crop.pdf: Samples/%.pdf
	$(PdfCrop) --clip  $<


Samples/%.pdf: Samples/%.tex
	$(PdfLaTeX) -interaction=batchmode -output-directory=Samples $<
	$(PdfLaTeX) -interaction=batchmode -output-directory=Samples $<


clean: cleanwork
	$(DelCmd) AllLectures.pdf


cleanwork:
	$(DelCmd) *.bak
	$(DelCmd) *.aux
	$(DelCmd) *.auxlock
	$(DelCmd) *.log
	$(DelCmd) *.toc
	$(DelCmd) *.nav
	$(DelCmd) *.snm
	$(DelCmd) *.out
	$(DelCmd) *.vrb
	$(DelCmd) *.lst
	$(DelCmd) *.idx
	$(DelCmd) *.ilg
	$(DelCmd) *.ind
	$(DelCmd) *.glo
	$(DelCmd) *.gls
	$(DelCmd) *.bbl
	$(DelCmd) *.bcf
	$(DelCmd) *.blg
	$(DelCmd) *.run.xml
	$(DelCmd) "Samples\*.pdf"

