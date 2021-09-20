#!/usr/bin/env bash

SECRET_TOKEN=$(curl -s \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${SECRET_GITHUB_PERSONAL_ACCCESS_TOKEN}" \
  ${SECRET_GITHUB_API_URL}/orgs/${SECRET_GITHUB_ORG}/actions/runners/registration-token | jq -r .token)

./config.sh --name "${SECRET_NAME}" --token "${SECRET_TOKEN}" --url "${SECRET_GITHUB_URL}/${SECRET_GITHUB_ORG}" --unattended --replace
./run.sh &
wait $!
