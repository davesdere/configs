#!/bin/bash

get_secret_from_keyvault() {
   local key_vault_name=${1}
   local secret_name=${2}

   resource="https://vault.azure.net"
   access_token="$(curl -s -H Metadata:true \
      "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&bypass_cache=true&resource=${resource}" | \
      jq -r ".access_token")"

   apiVersion="7.0"

   #
   # Fetch the latest version
   #
   secretVersion="$(curl -s -H "Authorization: Bearer ${access_token}" \
      "https://${key_vault_name}.vault.azure.net/secrets/${secret_name}/versions?api-version=${apiVersion}" | \
      jq -r ".value | sort_by(.attributes.created) | .[-1].id")"

   #
   # Fetch the actual secret's value
   #
   secret="$(curl -s -H "Authorization: Bearer ${access_token}" \
      "${secretVersion}?api-version=${apiVersion}" | \
      jq -r ".value" )"

   echo "${secret}"
}

echo "The secret is $(get_secret_from_keyvault "yourownkeyvaultname" "secret1")"
