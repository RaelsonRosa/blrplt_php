#!/bin/bash

echo "Iniciando pre-build"

# Copia arquivo .env para a raiz do projeto
# para que o devcontiner consiga encontra-lo
# durante o processo passando variaveis para docker-compose
rm .env 2> /dev/null
cp ./docker/.env .env