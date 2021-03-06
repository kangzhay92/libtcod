#!/bin/bash
set -e

# Fix shell_session_update errors.
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    wget -O - https://rvm.io/mpapis.asc | gpg --import -
    set +e
    rvm get head
fi

set -e

# Start X11 display on Linux
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    export DISPLAY=:99.0
    sh -e /etc/init.d/xvfb start
fi

# Install SCons on MacOS via pip
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py --user
    python -m pip install --user virtualenv
    python -m virtualenv ~/venv
    source ~/venv/bin/activate
    if [[ "$BUILD_TOOL" == "scons" ]]; then
        python -m pip install scons
    elif [[ "$BUILD_TOOL" == "autotools" ]]; then
        brew install sdl2
    fi
fi
