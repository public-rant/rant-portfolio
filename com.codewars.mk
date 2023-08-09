

# DOMAIN = "https://www.codewars.com/kata/search/my-languages?q=&r%5B%5D=-6&r%5B%5D=-5&r%5B%5D=-4&tags=Cryptography&beta=false&order_by=sort_date%20desc"
DOMAIN = https://www.codewars.com/api/v1/code-challenges
DRAFTS = src/content/codewars
$(DRAFTS): www.codewars.com-*.log
	-mkdir $@
	for id in $$(cat $^); do touch $@/$$id.json; done
	
$(DRAFTS)/%.json:
	curl -Ls $(DOMAIN)/$* | jq . > $@

codewars: $(DRAFTS)

codewars\:clean:
	-rm -rf $(DRAFTS)

src/content/drafts/codewars.mdx::
	-mkdir $$(dirname $@)
	touch $@
	pandoc $(DRAFTS) > $@

# TODO # And then iterate and run code with zx or codebraid
src/content/drafts/codewars.mdx::

