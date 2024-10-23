# .SUFFIXES: .pdf .tex
.DEFAULT_GOAL := help

#==============================================================================
# Clean/purge aux files
#==============================================================================
TEXAUX := *.aux *.bbl *.fdb_latexmk *.fls *.log *.nav *.out *.snm *.synctex.gz *.toc
.PHONY: cleantex
cleantex: ## Clean aux output files in LaTex compilation
	@echo "+ $@"
	rm -f $(TEXAUX)


#==============================================================================
# Inspecting
#==============================================================================
.PHONY: wordcount
wordcount: ## Wordcount via texcount
	@echo "==> $@"
	@echo "Check word count using texcount"
	dos2unix $(WORDCOUNT_SCR)
	$(WORDCOUNT_SCR)


ACRONYMS_SRC = ./inspecting/acronyms.sh
.PHONY: acronyms
acronyms: ## Find and tally acronyms
	@echo "==> $@"
	@echo "Check for acronyms"
	dos2unix $(ACRONYMS_SRC)
	chmod +x $(ACRONYMS_SRC)
	$(ACRONYMS_SRC)

.PHONY: duplicated_labels
duplicated_labels: ## Check for duplicated labels
	@echo "==> $@"
	@echo "Check for duplicated labels"
	grep -o '\\label{[^}]*}' $(SRC_TEX) | sort | uniq -cd

REPEATED_STRINGS_SRC = ./inspecting/repeatedstrings.sh
.PHONY: repeated_strings
repeated_strings: ## Check for repeated words
	@echo "==> $@"
	@echo "Check for repeated words (e.g. 'the the table shows...')"
	dos2unix $(REPEATED_STRINGS_SRC)
	-$(REPEATED_STRINGS_SRC)

UNREFERENCED_LABELS_SRC = ./inspecting/unreferenced_labels.sh
.PHONY: unreferenced_labels
unreferenced_labels: ## Check for label referencing
	@echo "==> $@"
	@echo "Check for unreferenced labels"
	dos2unix $(UNREFERENCED_LABELS_SRC)
	-$(UNREFERENCED_LABELS_SRC)

HARDCODEDNUMBERS_SRC = ./inspecting/hardcodednumbers.sh
.PHONY: hardcodednumbers
hardcodednumbers: ## Find hardcoded numbers
	@echo "==> $@"
	@echo "Check for hardcoded numbers"
	dos2unix $(HARDCODEDNUMBERS_SRC)
	$(HARDCODEDNUMBERS_SRC)

LINKCHECKER_SRC = ./inspecting/linkchecker.sh
.PHONY: linkchecker
linkchecker: ## Check URLs
	@echo "==> $@"
	@echo "Check that URLs work"
	dos2unix $(LINKCHECKER_SRC)
	$(LINKCHECKER_SRC)	

.PHONY: textidote
textidote: ## Check with textidote
textidote: ./inspecting/textidote_dict.txt
	@echo "==> $@"
	@echo "Check doc with textidote"
	-textidote --check en --dict $< --output html $(SRC_TEX) > inspecting/textidote.html

.PHONY: dueto
dueto: ## Find "due to"s; Did you mean "because of", "owing to", or "from"?
	@echo "==> $@"
	@echo "Find all the 'due to's in writing"
	grep -n "due to" $(SRC_TEX)

.PHONY: inspect
inspect: ## Do all inspections of manuscript
inspect: duplicated_labels \
         repeated_strings \
         unreferenced_labels \
         hardcodednumbers \
         acronyms \
         linkchecker \
         textidote \
         dueto \
         wordcount

#==============================================================================
# Help
#==============================================================================
.PHONY: help
help: ## Show this help message and exit 	
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'