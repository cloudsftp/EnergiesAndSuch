##
# Energies and Such
#
# @file
# @version 0.1

current_dir = $(shell pwd)

static: static/img/title.svg static/img/title-vertical.svg

static/img/%.svg: title/%.svg
	mv $< $@

%.svg: %.typ
	typst compile --font-path fonts $< $@
	inkscape --actions "select-all;fit-canvas-to-selection" --export-overwrite $@
	sed -i 's/fill="#ffffff"/fill="#e8e6e3"/' $@

open_sans_japanese_download = "https://fonts.gstatic.com/s/notosansjp/v52/-F6jfjtqLzI2JPCgQBnw7HFyzSD-AsregP8VFCMj75vY0rw-oME.ttf"
open_sans_japanese_file = "fonts/noto-sans-jp.ttf"

.PHONY: dep
dep:
	[ -f ${open_sans_japanese_file} ] \
		|| curl ${open_sans_japanese_download} -o ${open_sans_japanese_file}

.PHONY: clean
clean:
	rm fonts/*.ttf

# end
