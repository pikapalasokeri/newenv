#!/bin/bash

# Add paths to the repos here.
declare REPOS=(
              )

for REPO in "${REPOS[@]}"
do
    pushd ${REPO}
    /home/__USER__/bin/create_gtags.sh
    popd
done
