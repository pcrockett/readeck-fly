launch: fly.toml
	@flyctl launch --copy-config --yes
.PHONY: launch

deploy:
	@flyctl deploy
.PHONY: deploy

ssh: wake
	@flyctl ssh console
.PHONY: ssh

cleanup: wake
	@flyctl ssh console --command "readeck cleanup -config config.toml"
.PHONY: cleanup

backup: wake
	@./bin/backup.sh
.PHONY: backup

content-scripts: wake
	@./bin/upload-content-scripts.sh
.PHONY: content-scripts

restart:
	@flyctl scale count 0 --process-group web --yes
	@flyctl scale count 1 --process-group web --yes
.PHONY: restart

status:
	@flyctl status
.PHONY: status

logs:
	@flyctl logs --no-tail
.PHONY: logs

release:
	@gh release create --generate-notes --draft
.PHONY: release

deploy-token:
	@flyctl tokens create deploy
.PHONY: deploy-token

wake:
	@echo "Waking up server..."
	@curl "https://$(shell flyctl status --json | jq --raw-output .Hostname)" &>/dev/null
.PHONY: wake

fly.toml: fly.template.toml
	@cp fly.template.toml fly.toml
