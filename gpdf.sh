# generate a pdf from a markdown file
# uses pandoc and pdflatex
# open the pdf once compiled (need the `open` command)
# not maintained anymore but should still work 

if [ $1 = "-no-toc" ] ; then 
	filename="${2%%.*}"
	command="pandoc $2 -f markdown+tex_math_single_backslash -V geometry:margin=2.5cm -o $filename.pdf --highlight-style=tango --natbib --pdf-engine=pdflatex --standalone"
	eval $command
	open "$filename.pdf"
else 
	filename="${1%.*}"
	command="pandoc $1 -f markdown+tex_math_single_backslash -V geometry:margin=2.5cm -o $filename.pdf --toc --toc-depth=3 --highlight-style=tango --natbib --pdf-engine=pdflatex --standalone"
	eval $command 
	open "$filename.pdf"
fi
