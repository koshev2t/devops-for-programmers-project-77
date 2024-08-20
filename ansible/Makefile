setup:
	ansible-playbook playbook.yml -i inventory.ini --vault-password-file vault_password

deploy:
	ansible-playbook playbook.yml --tags deploy -i inventory.ini --vault-password-file vault_password

monitoring:
	ansible-playbook playbook.yml --tags datadog -i inventory.ini --vault-password-file vault_password

encrypt:
	ansible-vault encrypt --vault-password-file vault_password group_vars/webservers/vault.yml

decrypt:
	ansible-vault decrypt --vault-password-file vault_password group_vars/webservers/vault.yml