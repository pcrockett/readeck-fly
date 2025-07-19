launch: fly.toml
	@flyctl launch --copy-config --yes
.PHONY: launch

deploy:
	@flyctl deploy
.PHONY: deploy

ssh:
	@flyctl ssh console
.PHONY: ssh

cleanup:
	@flyctl ssh console --command "readeck cleanup -config config.toml"
.PHONY: cleanup

backup:
	@./bin/backup.sh
.PHONY: backup

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

fly.toml: fly.template.toml
	@cp fly.template.toml fly.toml
