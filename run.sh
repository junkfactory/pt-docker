#!/bin/bash

set -e

export PATH="$PATH:$PERCONA_TOOLKIT_SANDBOX/bin"
echo "PERCONA_TOOLKIT_BRANCH=$PERCONA_TOOLKIT_BRANCH"
echo "PERCONA_TOOLKIT_SANDBOX=$PERCONA_TOOLKIT_SANDBOX"
echo "PERL5LIB=$PERL5LIB"
echo "PATH=$PATH"
echo "RUN_TEST=$RUN_TEST"

if [ -d "$PERCONA_TOOLKIT_BRANCH/sandbox" ]; then
    cd "$PERCONA_TOOLKIT_BRANCH"
    ./sandbox/test-env start
fi

if [[ ${RUN_TEST} = "true" ]]; then
    if [ -d "$PERCONA_TOOLKIT_BRANCH/sandbox" ]; then
        TESTS="$@"
        if [ -z "$TESTS" ]; then
            TESTS=t/pt-*
        fi
        echo "TESTS:$TESTS"
        prove -v $TESTS
        exec ./sandbox/test-env stop
    else
        echo "$PERCONA_TOOLKIT_BRANCH not mounted, aborted."
        exit 1
    fi
else
    exec "$@"
fi
