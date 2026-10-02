SHELL := /bin/sh

DIST := dist
SCRAPERS := $(notdir $(patsubst %/manifest,%,$(wildcard */manifest)))

.PHONY: all build package index check clean

all: build

build: package index

$(DIST):
	mkdir -p $(DIST)

package: $(DIST)
	@set -e; \
	for scraper in $(SCRAPERS); do \
		rm -f "$(DIST)/$$scraper.zip"; \
		(cd "$$scraper" && zip -q -X -r "../$(DIST)/$$scraper.zip" manifest "$$scraper.yml"); \
	done

index: package
	ruby scripts/build_index.rb --input index.yml --output $(DIST)/index.yml --dist $(DIST) $(if $(VERSION),--version $(VERSION))

check: build
	ruby scripts/build_index.rb --input $(DIST)/index.yml --output /tmp/scrapers-index.yml --dist $(DIST) --check

clean:
	rm -rf $(DIST)
