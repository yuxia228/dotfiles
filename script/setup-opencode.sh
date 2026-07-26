#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)

curl -fsSL https://opencode.ai/install | bash

mkdir -p ${HOME}/.config/opencode/
ln -sf  ${SCRIPT_DIR}/../opencode/opencode.json ${HOME}/.config/opencode/opencode.json

# install plugin
git clone https://github.com/ByBrawe/opencode-loop.git --depth=1
cd opencode-loop
chmod +x ./scripts/install.sh
./scripts/install.sh
cd ../
rm -rf opencode-loop

# setup global gitignore
GLOBAL_IGNORE=${HOME}/.config/git/ignore
mkdir -p $( dirname ${GLOBAL_IGNORE} )
targets=("/.opencode")
for target in ${targets[@]}; do
    if [[ "$(grep "^${target}" ${GLOBAL_IGNORE})" == "" ]]; then
        echo "${target}" >> ${GLOBAL_IGNORE}
    fi
done

