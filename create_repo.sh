#!/bin/bash

#### 
#
# criacao do repositorio no github
#
####

if [ -z ${1} ]
then
	echo "Uso: create_repo.sh usuario_git nome_repo"
	exit 0
fi

vault_data_path="${HOME}/.vault_data"
vault_token=$(jq -r .user[] ${vault_data_path})
git_user=${1}
git_token=$(curl -vvv --header "X-Vault-Token: ${vault_token}" http://127.0.0.1:8200/v1/cubbyhole/secrets |jq -r .data.git)
git_repo=${2}
curl -vvv -u "${git_user}:${git_token}" -H "Accept: application/vnd.github.v3+json" --data "{\"name\":\"${git_repo}\"}" https://api.github.com/user/repos


####
#
# transformar pasta em git e carregar no repositorio
#
####


