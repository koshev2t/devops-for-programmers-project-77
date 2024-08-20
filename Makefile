init:
	terraform -chdir=terraform init

apply:
	terraform -chdir=terraform apply

destroy:
	terraform -chdir=terraform destroy

install:
	ansible-galaxy install -r ansible/requirements.yml

deploy:
	ansible-playbook -i ansible/inventory.ini --tags deploy --vault-password-file ansible/vault_password ansible/playbook.yml

monitoring:
	ansible-playbook -i ansible/inventory.ini --tags datadog --vault-password-file ansible/vault_password ansible/playbook.yml

encrypt:
	ansible-vault encrypt --vault-password-file ansible/vault_password ansible/group_vars/webservers/vault.yml

decrypt:
	ansible-vault decrypt --vault-password-file ansible/vault_password ansible/group_vars/webservers/vault.yml