# --metadata-file $^ 
# --filter $(STAGE) 
# upstream = filter1
# downstream = filter2

# downstream:
# 	@pandoc $(DOWNSTREAM) --template chatgpt.tmpl --metadata-file draft.json --verbose --filter ../rant-gpt/filters/convert_lists.py -f html -t gfm > src/content/drafts/test.md


# LLM ?= ../rant-gpt/filters/convert_lists.py

# FILES = *.html *.json

# .PHONY: $(CHAPTERS)
# COLLECTION = src/content/drafts
# chapters: $(CHAPTERS)
# 	for chapter in $?; do ${MAKE} $(COLLECTION)/$$chapter.md; done

# # JQ_FILTER = "{ title: .[0].title, questions: [.[].questions], publishDate: .[0].publishDate }"
# JQ_FILTER = $(shell cat filter.jq)
# %.json: %.html
# 	@pup json{} < $*.html | jq -f $*.jq | jq --arg slug $* -s $(JQ_FILTER) > $@

# %.html:
# 	@curl -Ls $(DOMAIN)/$* > $@

# $(COLLECTION)/%.md: %.json
# 	@pandoc --verbose --metadata-file $*.json --filter $(LLM) --template chatgpt.tmpl -t gfm $(DOMAIN)/$* > $@


# %.png:
# ${MAKE} $*.html	
# @pandoc -f html -t markdown $*.html >> $@
# echo "blockquote: |-" >> $@
# cat $*.html|pup 'blockquote,code text{}' | sed 's/&#39;/"/g' | sed 's/\.\.\.$///g' >> $@
# src/content/post/%.md: $(CHAPTERS).json
# 	@echo '---' > $@
# 	echo "title: $$(cat $*.html|pup 'json{}' | jq '.[0].children[0].children[0].children[0].text')" >> $@
# 	@cat $*.html | pup 'json{}' | jq '.[0].children[0].children[1].children[] | select(.tag == "ul").children[].text' | grep '?'  | jq -s '.[] | split("\n") | join(" ")' | jq -s '{ questions: . }' | yq -Y >> $@
# 	echo publishDate: "$(shell date +%Y-%m-%d)" >> $@
# 	@echo '---' >> $@
# 	cat $*.html|pup 'p,b,i text{}' | grep -v '?' >> $@
# 	cat $*.html|pup 'a' | lynx -dump -stdin >> $@



# return panflute-filters: [one, two, three] using astro to set list
# FILTERS = "convert_lists.py"
# FILTERS += "uppercase_headings.py"
# PANFLUTE_PATH = "$HOME"
# panflute.json:
# 	echo $(FILTERS) | jq -r -f $(basename $@ .json).jq > $@

# test: $(TARGETS)
# 	yarn $@ $?

TARGETS = planning-redux
TARGETS += basics
TARGETS += user-registration-and-management
TARGETS += planning
TARGETS += content-management
TARGETS += software-modularity
TARGETS += discussion
TARGETS += metadata
TARGETS += scaling
TARGETS += distributed-computing
TARGETS += user-activity-analysis
TARGETS += search

UPSTREAM = https://philip.greenspun.com/seia
DOWNSTREAM = http://localhost:3000

ifdef flag
DOMAIN = $(UPSTREAM)
endif
DOMAIN ?= $(DOWNSTREAM)


.PHONY: $(TARGETS)

all: $(TARGETS)
	for target in $?; do \
		${MAKE} -e DOMAIN=$(DOMAIN) $$target.json src/content/drafts/$$target.mdx; done

%.html:
	@curl -Ls $(UPSTREAM)/$* > $@

%.json: metadata.jq
	jq -nf $^ --arg slug $* --argfile panflute panflute.json > $@

# DOMAIN = '.' for cached responses
src/content/drafts/%.mdx: %.json %.html
	pandoc --verbose --filter panflute --metadata-file $*.json -f html -t gfm --template draft.mdx $(DOMAIN)/$* > $@

update-snapshots:
	yarn playwright test --update-snapshots

final: src/content/drafts/final.mdx

src/content/drafts/final.mdx: FINALS = $$(echo $(TARGETS) | jq -Rr 'split(" ")[] | "$(DOMAIN)/\(.)"')
src/content/drafts/final.mdx:
	pandoc -M draft=false -M title=test --template draft.mdx -f html -t gfm $(FINALS) -o $@