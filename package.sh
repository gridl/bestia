#!/bin/bash
# https://packaging.python.org/tutorials/packaging-projects/

PACKAGE=bestia
PACKAGE_VERSION=`cat setup.py | awk -F"\"|\'" '/version/{print $2}'`
PIP_VERSION=pip3
PURGE_DIRS=(dist build "$PACKAGE".egg-info)

# build
python3 setup.py sdist bdist_wheel || exit

# install
"$PIP_VERSION" show "$PACKAGE" &>/dev/null && "$PIP_VERSION" uninstall "$PACKAGE" -y
cd dist && "$PIP_VERSION" install "$PACKAGE"-"$PACKAGE_VERSION"-py3-none-any.whl && cd ..

# upload to PyPI
twine upload dist/*

# clean up
for dir in "${PURGE_DIRS[@]}"; do
    [ -d "$dir" ] && rm -rf "$dir" && echo "deleted $dir directory"
done