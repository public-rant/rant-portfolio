upwork.json: bookmarks_*
	cat $^ | pup a json{} | jq -r '.[].href' | grep upwork | jq -Rs 'split("\n")' > $@


JOBS = $(shell cat upwork.json | jq -r '.[] | split("/")[-2]' | tail -n 4 | head -n 2)
# need to run playwright individually using upwork.json feed arg to playwright

PDFS = src/content/pdfs
PROPOSALS = $(wildcard $(PROPOSALS)/*.pdf)
DRAFTS = src/content/proposals

# props: $(PROPOSALS) $(JOBS)
# 	-mkdir -p $(PDFS)
# 	for item in $?; do ${MAKE} $(DRAFTS)/$$item.md; done

# $(JOBS):
# 	${MAKE} $*.pdf


%.json:
	jq -nf metadata.jq --arg slug $* --arg title "FIXME" --argfile panflute panflute.json > $@

# # FIXME
PDF2TEXT = ./pdf2text.py
# # pandoc -t gfm --filter panflute --metadata-file panflute.json $* -o $@
# requires server running locally for first go
# python $(PDF2TEXT) $(PDFS)/$*.pdf > $@
# TODO flag to write initial text from pdfto text (or just fix dev server to convert to text on load)
$(DRAFTS)/%.md: %.json
	pandoc --filters panflute -f html -t gfm --metadata-file $*.json --template draft.mdx $(DOMAIN)/$* -o $@

props: $(JOBS)

$(PDFS)/%.pdf:
	@JOB=$* yarn playwright test tests/example.spec.ts

$(JOBS):
	@-mkdir -p $(PDFS)
	${MAKE} $(PDFS)/$@.pdf
	${MAKE} $(DRAFTS)/$@.md

 