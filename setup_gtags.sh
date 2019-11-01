#!/bin/bash

NEWENV_DIR=${1}

cp ${NEWENV_DIR}/cron_create_gtags_template.sh ${NEWENV_DIR}/cron_create_gtags.sh
USER=$(whoami)
sed "s/__USER__/${USER}/" -i ${NEWENV_DIR}/cron_create_gtags.sh
