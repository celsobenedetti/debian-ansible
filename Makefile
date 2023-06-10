run:
	ansible-playbook env_secrets.yml --ask-vault-pass -i inventory.ini
	. ~/.zshenv && ansible-playbook main.yml -i inventory.ini

vagrant: 
	USER=vagrant vagrant up

vagrant-pop:
	USER=vagrant;DISTRIBUTION=pop vagrant up
