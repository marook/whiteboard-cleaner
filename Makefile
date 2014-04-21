PREFIX=/usr/local

.PHONY: all
all:

.PHONY: install
install: ${PREFIX}/bin/whiteboard-cleaner

${PREFIX}/bin/whiteboard-cleaner: whiteboard-cleaner.sh
	install -D -m 0755 "$^" "$@"
