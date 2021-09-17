#!/usr/bin/env bash

./config.sh --name "$SECRET_NAME" --token "$SECRET_TOKEN" --url "$SECRET_GITHUB_URL" --unattended --replace
./run.sh &
wait $!
