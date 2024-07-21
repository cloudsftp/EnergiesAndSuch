##
# Energies and Such
#
# @file
# @version 0.1

current_dir = $(shell pwd)

static: title/title.png

%.png: %.eps fonts/*
	gs -dSAFER -dEPSCrop -r600 -sFONTMAP=${current_dir}/fonts/Fontmap.GS -sDEVICE=pngalpha -o $@ $<

.PHONY: dep
dep:
	curl https://fonts.gstatic.com/s/notosansjp/v52/-F6jfjtqLzI2JPCgQBnw7HFyzSD-AsregP8VFBEj75vY0rw-oME.ttf -o fonts/noto-sans-jp.ttf

.PHONY: clean
clean:
	rm title/*.png
	rm fonts/*.ttf

# end
