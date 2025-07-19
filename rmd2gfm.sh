#!/usr/bash
# cd 1/tmp
# pandoc -s --toc --gladtex instructions.md | gladtex -d eqn -o instructions.html -
Rscript -e 'knitr::knit("../instructions.rmd")'
pandoc -t json instructions.md | gladtex -d eqn -P - | pandoc -s -f json -t gfm --toc > gfm.md
# optional
pandoc -s gfm.md -o gfm.html

# adjust figure references:
# prepend 3/ to ="nn.png"/, ](nn.png), ](eqn/f.png) and "tmp_files/figure-gfm/f.png"
# sed -E -i 's/(]\(|"|'\'')([^)" ]+\.png)(\)|"|'\'')/\1'$i'\/\2\3/g' gfm.md 
