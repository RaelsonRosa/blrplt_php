# --------------------------------------------------------------------
# Copyright (c) 2020. All Rights Reserved.
# Author(s): Raelson Rosa
#
# This software may be modified and distributed under the terms of the
# MIT license. See the LICENSE file for details.
# --------------------------------------------------------------------
.PHONY: check_config init_config

EXISTS_DOCKER=$(shell  docker --version 2> /dev/null | wc -l )
EXISTS_DOCKER_COMPOSE=$(shell  docker-compose --version 2> /dev/null | wc -l )
EXISTS_VOLUME_EXT=$(shell docker volume ls 2> /dev/null | grep vsext_php | wc -l)
EXISTS_COMPOSERPHAR=$(shell [ -f bin/composer.phar ] && echo 1 || echo 0)

init_config:
	@echo "INICIANDO CONFIGURAÇÃO"
	@echo "----------------------"

	@if [ ${EXISTS_COMPOSERPHAR} = 0 ]; then\
		echo "INSTALAÇÃO COMPOSER NÃO ENCONTRADA";\
		echo "Baixando composer";\
		curl https://getcomposer.org/download/2.0.9/composer.phar -o bin/composer.phar;\
	fi

	@if [ ${EXISTS_DOCKER} = 0 ]; then\
		echo "INSTALAÇÃO DOCKER NÃO ENCONTRADA";\
		exit 1;\
	fi

	@if [ ${EXISTS_DOCKER_COMPOSE} = 0 ]; then\
		echo "INSTALAÇÃO DOCKER-COMPOSE NÃO ENCONTRADA.";\
		echo "Antes de iniciar o projeto, instale docker-compose!";\
		exit 1;\
	fi

	@if [ ${EXISTS_VOLUME_EXT} = 1 ]; then\
		echo "### Volume já inicializado ###";\
	else\
		docker volume create vsext_php;\
    fi

	@echo ""
	@echo "CONFIGURAÇÃO FINALIZADA!!!"
	@echo "----------------------"
