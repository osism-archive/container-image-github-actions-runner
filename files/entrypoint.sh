#!/usr/bin/env bash

SECRET_TOKEN=$(python3 get_token.py)
./config.sh --name "${SECRET_NAME}" --token "${SECRET_TOKEN}" --url "${SECRET_GITHUB_URL}/${SECRET_GITHUB_ORG}" --unattended --replace
./run.sh &
wait $!
