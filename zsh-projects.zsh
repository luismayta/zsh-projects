#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install projects for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#

projects_package_name='projects'
PROJECTS_ROOT_DIR=$(dirname "$0")
PROJECTS_SRC_DIR="${PROJECTS_ROOT_DIR}"/src

function cookiecutter::install {
    message_info "Installing cookiecutter for ${projects_package_name}"
    if type -p pip > /dev/null; then
        pip install --user cookiecutter
        message_success "Installed cookiecutter for ${projects_package_name}"
    fi
}

function projects::list {
    # shellcheck disable=SC2002
    cat "${PROJECTS_SRC_DIR}"/data.json | jq '.projects[] | "\(.name) | \(.type) | \(.description) | \(.repository)"'
}

function projects::find {
    local command_value
    command_value=$(projects::list \
                    | fzf \
                    | awk '{print $(NF -0)}' \
                    | perl -pe 'chomp' \
                    | sed 's/\"//g'
                )
    cookiecutter "${command_value}"
}

if ! type -p cookiecutter > /dev/null; then cookiecutter::install; fi
