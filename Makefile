include com.greenspun.mk
include com.upwork.mk

# pull from domain
# count tokens | filter data
# generate prompt while in draft mode hold on to prompots to not waste money
# generate production data when draft is false
# run ML on prompts to gain learning insight.
# analysis of prompts give insight into further reading
# need to track finetuning and maybe use private gpt etc.
# if the content is tracked correctly and labelled, posts will gradually be more readable
# also the GPT Times idea
#
# make 
# make release 
# make backup

# backup the data
# commit the code
# publish the content
# what about private gpt vectorize images?


# Produce a standalone HTML file with no external dependencies, using data: URIs to incorporate the contents of linked scripts, stylesheets, images, and videos. The resulting file should be “self-contained,” in the sense that it needs no external files and no net access to be displayed properly by a browser. This option works only with HTML output formats, including html4, html5, html+lhs, html5+lhs, s5, slidy, slideous, dzslides, and revealjs. Scripts, images, and stylesheets at absolute URLs will be downloaded; those at relative URLs will be sought relative to the working directory (if the first source file is local) or relative to the base URL (if the first source file is remote). Elements with the attribute data-external="1" will be left alone; the documents they link to will not be incorporated in the document. Limitation: resources that are loaded dynamically through JavaScript cannot be incorporated; as a result, fonts may be missing when --mathjax is used, and some advanced features (e.g. zoom or speaker notes) may not work in an offline “self-contained” reveal.js slide show.

all: drafts