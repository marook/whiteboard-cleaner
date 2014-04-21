PREFIX=/usr/local

.PHONY: all
all:

.PHONY: install
install: ${PREFIX}/bin/whiteboard-cleaner

${PREFIX}/bin/whiteboard-cleaner: whiteboard-cleaner.sh
	install -D -m 0755 "$^" "$@"

.PHONY: test
test: target/IMG_20140406_195919_a.png target/IMG_20140406_195919_b.png

target/IMG_20140406_195919_a.png: test/IMG_20140406_195919.jpg
	mkdir -p -- `dirname "$@"`
	/bin/bash whiteboard-cleaner.sh "$^" "$@"

target/IMG_20140406_195919_b.png: test/IMG_20140406_195919.jpg
	mkdir -p -- `dirname "$@"`
	cp "$^" "$@"
	/bin/bash whiteboard-cleaner.sh "$@"

.PHONY: clean
clean:
	rm -rf -- target
