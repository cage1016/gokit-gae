all: help

.PHONY: all help

PD_SOURCES:=$(shell find ./pb -type d)
proto:
	@for var in $(PD_SOURCES); do \
		if [ -f "$$var/compile.sh" ]; then \
			cd $$var && ./compile.sh; \
			echo "complie $$var/$$(basename $$var).proto"; \
			cd $(PWD); \
		fi \
	done

# Regenerates OPA data from rego files
HAVE_GO_BINDATA := $(shell command -v go-bindata 2> /dev/null)
generate:
ifndef HAVE_GO_BINDATA
	@echo "requires 'go-bindata' (go get -u github.com/kevinburke/go-bindata/go-bindata)"
	@exit 1 # fail
else
	go generate ./...
endif

help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
	@echo ""
	@for var in $(helps); do \
		echo $$var; \
	done | column -t -s ':' |  sed -e 's/^/  /'