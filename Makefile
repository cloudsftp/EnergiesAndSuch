##
# Energies and Such
#
# @file
# @version 0.1

current_dir = $(shell pwd)

images = 	static/img/favicon-light.svg \
			static/img/favicon-dark.svg \
			static/img/apple-touch-icon.png

text_color = \#e8e6e3

static: $(images) static/noto-sans-jp-subset.ttf

static/img/%.svg: img-src/%.svg
	mv $< $@

%-light.svg: %.typ
	typst compile --font-path fonts $< $@
	inkscape --actions "select-all;fit-canvas-to-selection" --export-overwrite $@

%-dark.svg: %.typ
	typst compile --font-path fonts $< $@
	inkscape --actions "select-all;fit-canvas-to-selection" --export-overwrite $@
	sed -i 's/fill="#ffffff"/fill="black"/' $@

static/img/apple-touch-icon.png: img-src/apple-touch-icon.svg
	inkscape 	--export-width 512 \
				--export-height 512 \
				$< -o $@
	magick $@ -border 50 $@

%.svg: %.typ
	typst compile --font-path fonts $< $@
	inkscape --actions "select-all;fit-canvas-to-selection" --export-overwrite $@
	sed -i 's/fill="#ffffff"/fill="$(text_color)"/' $@

# Fonts

static/noto-sans-jp-subset.ttf: fonts/noto-sans-jp.ttf fonts/subset-characters
	pyftsubset $< \
		--output-file=$@ \
		--obfuscate-names \
		--text-file=$(word 2,$^)

open_sans_japanese_download = "https://fonts.gstatic.com/s/notosansjp/v52/-F6jfjtqLzI2JPCgQBnw7HFyzSD-AsregP8VFCMj75vY0rw-oME.ttf"
open_sans_japanese_file = "fonts/noto-sans-jp.ttf"

.PHONY: dep
dep:
	[ -f $(open_sans_japanese_file) ] \
		|| curl $(open_sans_japanese_download) -o $(open_sans_japanese_file)

.PHONY: clean
clean:
	rm fonts/*.ttf

# end
