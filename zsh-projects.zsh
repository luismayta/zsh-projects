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

function projects::list {
    cat "${PROJECTS_SRC_DIR}"/data.json | jq '.projects[] | "\(.name) | \(.type) | \(.description) | \(.command)"'
}

function projects::find {
    projects::list | fzf
}
