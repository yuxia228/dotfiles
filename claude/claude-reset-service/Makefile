# Makefile

MAKEFILE_DIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
PARENT_DIR_NAME := $(shell basename $(dir $(realpath $(firstword $(MAKEFILE_LIST)))))
SERVICE_FNAME=$(PARENT_DIR_NAME).service
TIMER_FNAME=$(PARENT_DIR_NAME).timer

.PHONY: help
help:
	@echo "Usage:"
	@echo "    make help:"
	@echo "        show this message"
	@echo "    make install:"
	@echo "        install service"
	@echo "        If you wanna update the service file, try this command"
	@echo "    make TARGET(start/stop/status/enable/disable/restart)"
	@echo "        run systemctl --user {TARGET} ${SERVICE_FNAME}"
	@echo "        run systemctl --user {TARGET} ${TIMER_FNAME}"

.PHONY: install
install:
	# install service file
	@mkdir -p ${HOME}/.config/systemd/user/
	@cp -f ${SERVICE_FNAME} -t ${HOME}/.config/systemd/user/
	@cp -f ${TIMER_FNAME} -t ${HOME}/.config/systemd/user/
	@systemctl --user daemon-reload
	@systemctl --user enable ${TIMER_FNAME}
	@systemctl --user start ${TIMER_FNAME}
	@echo Setup server is finished
	# Usage
	@echo ""
	@echo "Usage:"
	@echo "    make TARGET(start/stop/status/enable/disable)"
	@echo "        run systemctl --user {TARGET} ${SERVICE_FNAME}"
	@echo "        run systemctl --user {TARGET} ${TIMER_FNAME}"

.PHONY: start stop status enable disable restart
start stop status enable disable restart:
	@systemctl --user $@ ${TIMER_FNAME} | cat
	@systemctl --user $@ ${SERVICE_FNAME} | cat

.PHONY: journalctl
journalctl:
	@journalctl --user -fu ${SERVICE_FNAME}

