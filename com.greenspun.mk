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
# .PHONY: $(TARGETS)

# all: staging.json
# 	echo done

# $(COLLECTION): $(TARGETS)
# 	mkdir $@
# 	for target in $?; do touch $@/$$target.mdx; done

# $(METADATA): $(TARGETS)
# 	mkdir $@
# 	for target in $?; do touch $@/$$target.json; done

# %.html:
# 	@curl -Ls $(DOMAIN)/$* > $@

# $(METADATA)/%.json: $(METADATA)
# 	jq -nf $*.jq --arg slug $* --argfile panflute panflute.json > $@

# # DOMAIN = '.' for cached responses
# $(COLLECTION)/%.mdx: $(COLLECTION)
# 	pandoc --verbose --filter panflute --metadata-file $(METADATA)/$*.json -f html -t gfm --template draft.mdx $(DOMAIN)/$* > $@

# update-snapshots:
# 	yarn playwright test --update-snapshots

# index: src/content/drafts/index.mdx

# $(COLLECTION)/index.mdx: FINALS = $$(echo $(TARGETS) | jq -Rr 'split(" ")[] | "$(DOMAIN)/\(.)"')
# $(COLLECTION)/index.mdx:
# 	pandoc -M draft=false -M title=test -M slug=test --template draft.mdx -f html -t gfm $(FINALS) -o $@

# staging.json: METADATA = src/content/meta/*.json
# staging.json: DRAFTS = src/content/drafts/*.mdx
# staging.json: $(METADATA) $(DRAFTS) 
# 	yarn astro build
# 	netlify deploy --json > $@

# production.json:
# 	netlify deploy --prod --json > $@
# 	git commit
# 	git push

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

DRAFTS = src/content/drafts
METADATA = src/content/meta
DOMAIN=$$(jq -r .deploy_url < staging.json)

STAGING ?= "$$(cat staging.json)"#'{ "deploy_url": "https://philip.greenspun.com/seia" }'

DEPLOY_URL = $$(jq -rn --argjson staging $(STAGING) '$$staging.deploy_url')

# ${MAKE} $(DRAFTS)/*.mdx
# Notice filters applied
# With tests
# Now deploy first version
# make staging.json
# Keep iterating, unset staging flag to start again
# Notice changes are tracked in git (with calendar)
# deploy to production
# make production.json
# $(COLLECTION)/index.mdx: FINALS = $$(echo $(TARGETS) | jq -Rr 'split(" ")[] | "$(DOMAIN)/\(.)"')
# $(COLLECTION)/index.mdx:
# 	pandoc -M draft=false -M title=test -M slug=test --template draft.mdx -f html -t gfm $(FINALS) -o $@

.PHONY: staging.json production.json

$(DRAFTS): clean
	mkdir $@
	mkdir $(METADATA)
	for target in $(TARGETS); do touch $(DRAFTS)/$$target.mdx; done
	${MAKE} -B $@/*.mdx

$(METADATA)/%.json:
	jq -nf metadata.jq --arg slug $* --argfile panflute panflute.json > $@

$(DRAFTS)/%.mdx: $(METADATA)/%.json
	pandoc --verbose --filter panflute --metadata-file $(METADATA)/$*.json -f html -t gfm --template draft.mdx $(DEPLOY_URL)/$* > $@

staging.json: $(DRAFTS)/*.mdx build
	netlify deploy --json > $@

build:
	yarn astro build

production.json: build
	netlify deploy --prod --json > $@

clean:
	rm -rf $(DRAFTS) $(METADATA)