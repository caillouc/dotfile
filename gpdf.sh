# generate a pdf from a markdown file
# uses pandoc and pdflatex

if [ $1 = "-no-toc" ] ; then 
	filename="${2%%.*}"
	command="pandoc $2 \
		-V geometry:margin=2.5cm \
		-V linkcolor:blue \
		--highlight-style=tango \
		--pdf-engine=pdflatex \
		--standalone \
		-o $filename.pdf"
	eval $command
else 
	filename="${1%.*}"
	command="pandoc $1 \
		-V geometry:margin=2.5cm \
		-V linkcolor:blue \
		--toc \
		--toc-depth=3 \
		--highlight-style=tango \
		--pdf-engine=pdflatex \
		--standalone \
		-o $filename.pdf"
	eval $command 
fi
