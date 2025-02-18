CleanWorkExt := *.aux *.auxlock *.log *.toc *.nav *.snm *.out *.vrb *.idx *.ilg *.ind *.glo *.gls *.bbl *.bcf *.blg *.hd *.run.xml 
PdfLaTeX := pdflatex
PdfCrop := pdfcrop
Biber := biber
DelCmd := rm -f


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
	$(foreach var, $(CleanWorkExt), $(DelCmd) ./$(var);)
	$(foreach var, $(CleanWorkExt), $(DelCmd) ./Samples/$(var);)
	$(DelCmd) ./Samples/*-crop.pdf
