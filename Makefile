.DEFAULT_GOAL := explain

.PHONY: explain
explain:
	@echo flux
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: setup
setup: ## Install pre-commit hooks
	@pre-commit install

.PHONY: build
build: ## Build flux
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o bin/app cmd/app/main.go

.PHONY: run
run: build ## Build and run flux
	@./bin/app

.PHONY: clean
clean: ## Clean up build artifacts
	@rm -rf bin
