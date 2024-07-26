##
# Energies and Such
#
# @file
# @version 0.1

current_dir = $(shell pwd)

images = 	static/img/title.svg \
			static/img/title-vertical.svg \
			static/img/favicon.svg \
			static/img/apple-touch-icon.png

background_color = \#181a1b
text_color = \#e8e6e3

static: $(images)

static/img/%.svg: img-src/%.svg
	mv $< $@

%.svg: %.typ
	typst compile --font-path fonts $< $@
	inkscape --actions "select-all;fit-canvas-to-selection" --export-overwrite $@
	sed -i 's/fill="#ffffff"/fill="$(text_color)"/' $@

static/img/apple-touch-icon.png: static/img/favicon.svg
	inkscape 	--export-width 512 \
				--export-height 512 \
				--export-background "$(background_color)" \
				$< -o $@
	magick $@ -bordercolor "$(background_color)" -border 50 $@

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
