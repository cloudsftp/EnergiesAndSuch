##
# Energies and Such
#
# @file
# @version 0.1

current_dir = $(shell pwd)

static: static/title.svg

static/%.svg: title/%.svg
	cp $< $@

%.svg: %.typ
	typst compile --font-path fonts $< $@
	inkscape --actions "select-all;fit-canvas-to-selection" --export-overwrite $@

.PHONY: dep
dep:
	curl https://fonts.gstatic.com/s/notosansjp/v52/-F6jfjtqLzI2JPCgQBnw7HFyzSD-AsregP8VFBEj75vY0rw-oME.ttf -o fonts/noto-sans-jp.ttf

.PHONY: clean
clean:
	rm title/*.svg
	rm fonts/*.ttf

# end
