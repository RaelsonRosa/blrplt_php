#!/bin/bash

echo "Iniciando script após conectar container"

ls -la

cat .devcontainer/.bashrc >> ~/.bashrc
cat .vscode/settings.json > /root/.vscode-server/data/Machine/settings.json

# apaga arquivo .env da raiz do projeto
rm .env 2> /dev/null



source ~/.bashrc