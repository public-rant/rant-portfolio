# SECTIONS = data-structures algorithms
# all: $(SECTIONS)
# %: src/content/post/%.md
# 	@echo $<


$(SECTIONS):
	@for item in $$(find javascript-algorithms/src/$@ -name '*.js' -not -path '*/__test__/*'); do ${MAKE} -sB $$item; done

javascript-algorithms/src/%:
	@echo --- > $$(basename $* .js).md.txt
	@echo "tags: $$(dirname $* | jq -cR 'split("/")')" >> $$(basename $* .js).md.txt
	@echo publishDate: "$(shell date +%Y-%m-%d)" >> $$(basename $* .js).md.txt
	@echo --- >> $$(basename $* .js).md.txt
	@echo "# $*" >> $$(basename $* .js).md.txt
	@rg '//' $@ -g '!*.test.js' -g '!*.md' --json | jq -rsc '.[] | select(.type == "match").data.lines.text' >> $$(basename $* .js).md.txt
	@sed 's/\/\///g' $$(basename $* .js).md.txt > src/content/compsci/$$(basename $* .js).md

# clean:
# 	rm -rf *.md *.txt

# test/%:
# 	INPUT='[1,5,3]' yarn zx src/content/compsci/$*.md
		
		

# tag ?= ul


# # post processing
# # 

# # 	ul,p is user
# # 	h3 is for user
# # 	p is | grep -v ? for assistant

# # 	blockquote,code for code
# # 	what about ol? and the rest?

# # [
#   "a",


# #   "br",
# #   "center",
# #   "cite",
#   "blockquote",
#   "code",
# #   "em",
# #   "form",
#   "h2",
#   "h3",
#   "h4",
# #   "hr",
#   "i",
#   "b",
# #   "ol",
# #   "p",
# #   "span",
# #   "sup",
#   "table",
# #   "ul"
# # ]

# todo: content-management.html


# src/content/post/%.txt:
# 	pup 'code,blockquote text{}' > $@
	

# # user-registration-and-management \
# # https://philip.greenspun.com/seia/user-activity-analysis
# # https://philip.greenspun.com/seia/software-modularity



# # planning-redux
# # basics
# # user-registration-and-management
# # planning
# # content-management
# # software-modularity
# # discussion
# # metadata
# # scaling
# # distributed-computing
# # user-activity-analysis
# # search