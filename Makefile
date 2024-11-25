.PHONY: all setup run clean

# Variables
SHELL := /bin/bash
PDF_OUTPUT = jeff.pdf
LATEX_TEMPLATE = ./template/default.latex
RESUME_SOURCE = resume.md
HEADER = header.tex

# Default target
all: setup run

# Setup dependencies
setup:
	@echo "🚀 Setting up dependencies..."
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Error: Homebrew is not installed"; \
		exit 1; \
	fi
	@brew install pandoc tectonic
	@echo "✅ Setup complete"

# Generate PDF
run: $(RESUME_SOURCE) $(LATEX_TEMPLATE) $(HEADER)
	@echo "📄 Generating PDF..."
	@pandoc --verbose $(RESUME_SOURCE) \
		--pdf-engine=tectonic \
		--template=$(LATEX_TEMPLATE) \
		-H $(HEADER) \
		-o $(PDF_OUTPUT)
	@echo "✅ PDF generated successfully!"
	@open $(PDF_OUTPUT)

# Clean generated files
clean:
	@echo "🧹 Cleaning up..."
	@rm -f $(PDF_OUTPUT)
	@echo "✅ Cleanup complete"

# Help
help:
	@echo "Available commands:"
	@echo "  make setup  - Install required dependencies"
	@echo "  make run    - Generate PDF from resume"
	@echo "  make clean  - Remove generated PDF"
	@echo "  make all    - Run setup and generate PDF"
	@echo "  make help   - Show this help message" 