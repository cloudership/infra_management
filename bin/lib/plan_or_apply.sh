#!/bin/bash

set -euo pipefail

SCRIPT_LIB_DIR="$(realpath -e "$(dirname "${BASH_SOURCE[0]}")")"
REPO_ROOT_DIR="$(realpath -e "${SCRIPT_LIB_DIR}/../..")"

USAGE="Usage: ${0} [--local] ENV_NAME COMPONENT_DIR PLAN_FILE [OTHER_TF_ARGS ...]"

error_exit() {
    echo "${1:-error}" >&2
    exit 1
}

check_arg() {
  if [[ -z "${1}" ]] ; then
    echo "${2:-error}" >&2
    echo "${USAGE}" >&2
    exit 1
  fi
}

USE_LOCAL_SOURCE=""
if [[ "${1:-}" = "--local" ]]; then
  USE_LOCAL_SOURCE="1"
  shift
fi

ENV_NAME="${1:-}"
check_arg "${ENV_NAME}" "1st arg must be env name"
shift

REL_COMPONENT_DIR="${1:-}"
check_arg "${REL_COMPONENT_DIR}" "2nd arg must be component name"
shift
COMPONENT_DIR="${REPO_ROOT_DIR}/live/${ENV_NAME}/${REL_COMPONENT_DIR}"

[[ ! -d "${COMPONENT_DIR}" ]] && error_exit "${COMPONENT_DIR} does not exist"

PLAN_FILE="${1:-}"
check_arg "${PLAN_FILE}" "3rd arg must be plan file"
shift

if [[ "${USE_LOCAL_SOURCE}" == "1" ]] ; then
  LOCAL_SOURCE_DIR="${REPO_ROOT_DIR}/../$(sed -nEe 's/\s+source = "git::git@github.com:[^/]+\/(\w+)\.git.+/\1/p' \
                                  < "${COMPONENT_DIR}/terragrunt.hcl")"
  LOCAL_SOURCE_DIR="$(realpath -e "${LOCAL_SOURCE_DIR}")"
  if [[ -d "${LOCAL_SOURCE_DIR}/infra" ]]; then
    LOCAL_SOURCE_ARGS="--terragrunt-source ${LOCAL_SOURCE_DIR}//infra"
  else
    LOCAL_SOURCE_ARGS="--terragrunt-source ${LOCAL_SOURCE_DIR}"
  fi
fi

cd "${COMPONENT_DIR}"
