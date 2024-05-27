bluesnooze: bluesnooze.m
	clang -Wall -Wconversion -Werror -fobjc-arc -framework Cocoa -framework IOBluetooth bluesnooze.m -o bluesnooze

.PHONY: clean

clean:
	rm bluesnooze

.PHONY: install

install: bluesnooze
	mkdir -p "$(HOME)/.local/bin/"
	cp bluesnooze "$(HOME)/.local/bin/"
	mkdir -p "$(HOME)/Library/LaunchAgents/"
	sed "s|BLUESNOOZE_PATH|$(HOME)/.local/bin/bluesnooze|g" bluesnooze.plist >"$(HOME)/Library/LaunchAgents/bluesnooze.plist"
	launchctl unload "$(HOME)/Library/LaunchAgents/bluesnooze.plist" 2>/dev/null || true
	launchctl load "$(HOME)/Library/LaunchAgents/bluesnooze.plist"
