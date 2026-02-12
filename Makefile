.DEFAULT_GOAL := help

# ──────────────────────────────────────────────────────────────
# {{PROJECT_NAME}} — Developer Commands
# ──────────────────────────────────────────────────────────────

.PHONY: help lint format typecheck test test-quick coverage security
.PHONY: fix check notify clean

# ── Quality ────────────────────────────────────────────────────

lint: ## Run ruff linter on src and tests
	uv run ruff check src/ tests/

format: ## Format code with ruff
	uv run ruff format src/ tests/

fix: ## Auto-fix lint issues + format
	uv run ruff check --fix src/ tests/ && uv run ruff format src/ tests/

typecheck: ## Run mypy type checking
	uv run mypy src/

check: lint typecheck test ## Run all checks (lint + types + tests)

# ── Testing ────────────────────────────────────────────────────

test: ## Run full test suite
	uv run pytest tests/ -v --timeout=120

test-quick: ## Run tests (fail-fast, quiet)
	uv run pytest tests/ -x -q --tb=short --timeout=60

coverage: ## Run tests with coverage report
	uv run pytest tests/ --cov=src/ --cov-report=term-missing --timeout=120

# ── Security ───────────────────────────────────────────────────

security: ## Run bandit security scan
	uvx bandit -r src/ -ll --skip B101

# ── Notifications ──────────────────────────────────────────────

notify: ## Send ntfy notification (usage: make notify MSG="Done!")
	@if [ -n "$$NTFY_TOPIC" ]; then \
		curl -s -H "Title: 📋 $(MSG)" -d "$(MSG)" ntfy.sh/$$NTFY_TOPIC; \
	else \
		echo "NTFY_TOPIC not set — skipping notification"; \
	fi

# ── Maintenance ────────────────────────────────────────────────

clean: ## Remove Python cache files
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	rm -rf .pytest_cache .mypy_cache .ruff_cache htmlcov

# ── Help ───────────────────────────────────────────────────────

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
