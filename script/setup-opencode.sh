#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)

curl -fsSL https://opencode.ai/install | bash

mkdir -p ${HOME}/.config/opencode/agents/
ln -sf  ${SCRIPT_DIR}/../opencode/opencode.json ${HOME}/.config/opencode/opencode.json
ln -sf  ${SCRIPT_DIR}/../claude/CLAUDE.md ${HOME}/.config/opencode/CLAUDE.md
ln -sf  ${SCRIPT_DIR}/../opencode/AGENTS.md ${HOME}/.config/opencode/AGENTS.md
ln -sf  ${SCRIPT_DIR}/../opencode/explorer.md ${HOME}/.config/opencode/agents/
rtk init -g --opencode

# install plugin
git clone https://github.com/ByBrawe/opencode-loop.git --depth=1
cd opencode-loop
chmod +x ./scripts/install.sh
./scripts/install.sh
cd ../
rm -rf opencode-loop
# cleanup: Remove specific version from opencode.json
sed -i ${SCRIPT_DIR}/../opencode/opencode.json \
    -e 's|@bybrawe/opencode-loop@.*"]|@bybrawe/opencode-loop"]|'

# setup global gitignore
GLOBAL_IGNORE=${HOME}/.config/git/ignore
mkdir -p $( dirname ${GLOBAL_IGNORE} )
targets=(".opencode")
for target in ${targets[@]}; do
    if [[ "$(grep "^${target}" ${GLOBAL_IGNORE})" == "" ]]; then
        echo "${target}" >> ${GLOBAL_IGNORE}
    fi
done

