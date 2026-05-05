.PHONY: help serve stop build clean new post deploy logos

# Default target
.DEFAULT_GOAL := help

# Hugo flags matching GitHub Actions deploy.yml
HUGO_FLAGS := --gc --minify --baseURL "https://kaiychen9.github.io/"

help: ## Show this help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

stop: ## Stop the local Hugo server
	@PID=$$(lsof -t -i :1313 2>/dev/null); \
	if [ -n "$$PID" ]; then \
		kill $$PID && echo "Hugo server stopped."; \
	else \
		echo "No Hugo server running on port 1313."; \
	fi

build: ## Build production site (matches GitHub Pages output)
	hugo $(HUGO_FLAGS)

clean: ## Remove generated build artifacts
	@rm -rf public/
	@rm -f .hugo_build.lock
	@echo "Cleaned build artifacts."

new: ## Create a new post (usage: make new POST=posts/my-title.md)
ifndef POST
	@echo "Error: POST variable is required."
	@echo "Usage: make new POST=posts/my-title.md"
	@exit 1
endif
	hugo new $(POST)

post: ## Alias for 'make new'
	@$(MAKE) new POST=$(POST)

serve: ## Start local dev server with drafts enabled
	make stop
	make clean
	make build
	hugo server -D --bind 0.0.0.0 --port 1313
	
deploy: ## Build, commit, and push to trigger GitHub Pages deployment
	@git add -A
	@git commit -m "$(or $(MSG),Update site content)" || true
	@git push origin main
	@echo "Pushed to main. GitHub Actions will deploy shortly."
	@echo "Check progress at: https://github.com/kaiychen9/kaiychen9.github.io/actions"

logos: ## Download company logos for the timeline (run once)
	@mkdir -p static/images/logos
	@echo "Downloading Huawei logo..."
	@curl -sSL -A "Mozilla/5.0" -o static/images/logos/huawei.svg \
		"https://commons.wikimedia.org/wiki/Special:FilePath/Huawei_Standard_logo.svg"
	@echo "Downloading Qualcomm logo..."
	@curl -sSL -A "Mozilla/5.0" -o static/images/logos/qualcomm.svg \
		"https://commons.wikimedia.org/wiki/Special:FilePath/Qualcomm-Logo.svg"
	@echo "Downloading DJI logo..."
	@curl -sSL -A "Mozilla/5.0" -o static/images/logos/dji.svg \
		"https://commons.wikimedia.org/wiki/Special:FilePath/DJI_Innovations_logo.svg"
	@echo ""
	@echo "Done. Logos saved to static/images/logos/"
	@ls -lh static/images/logos/
