run:
	ansible-playbook env_secrets.yml --ask-vault-pass
	. ~/.zshenv && ansible-playbook main.yml
