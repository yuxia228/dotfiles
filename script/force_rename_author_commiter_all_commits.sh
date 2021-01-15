#!/bin/bash

git filter-branch -f --env-filter "\
    GIT_AUTHOR_NAME='yuxia228'; \
    GIT_AUTHOR_EMAIL='yuxia228@gmail.com'; \
    GIT_COMMITTER_NAME='yuxia228'; \
    GIT_COMMITTER_EMAIL='yuxia228@gmail.com'; \
    " HEAD

