init:
	terraform -chdir=terraform init

tf-validate:
	terraform -chdir=./terraform validate

plan:
	terraform -chdir=terraform plan

apply:
	bash -chdir=terraform ./apply_configuration.sh

destroy:
	terraform -chdir=terraform destroy

install:
	ansible-galaxy install -r ansible/requirements.yml

deploy:
	ansible-playbook -i ansible/inventory.ini -v --vault-password-file ansible/vault-password ansible/playbook.yml

encrypt:
	ansible-vault encrypt --vault-password-file ansible/vault-password ansible/group_vars/webservers/vault.yml

decrypt:
	ansible-vault decrypt --vault-password-file ansible/vault-password ansible/group_vars/webservers/vault.yml