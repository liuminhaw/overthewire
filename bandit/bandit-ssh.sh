#!/bin/bash

# Author: haw
# Error code:
#   1 - Usage error
#   2 - Command not exist


# ----------------------------------------------------------------------------
# Function definition
#
# Usage: show_help
# ----------------------------------------------------------------------------
show_help() {
cat << EOF
Usage: ${0##*/} [--help] LEVEL [COMMAND...]
    --help                  Display this help message and exit
    COMMAND                 Command to execute via ssh
EOF
}

_SCRIPT=$(basename ${0})

# Command line options
while :; do
    case ${1} in
        --help)
            show_help
            exit 0
            ;;
        -?*)
            echo "WARN: Unknown option (ignored): ${1}" 1>&2
            ;;
        *)  # Default case: no more options
            break
    esac

    shift
done

# USAGE: bandit-ssh.sh LEVEL
if [[ "${#}" -lt 1 ]]; then
    show_help
    exit 1
fi

# sshpass command 
which sshpass 1> /dev/null
if [[ "${?}" -ne 0 ]]; then
    echo "No such command: sshpass"
    exit 2
fi

_level=${1}
_user="bandit${_level}"
shift

if [[ ${_level} -lt 10 ]]; then
    _level="0${_level}"
fi

_password_file="level${_level}.txt"
_pem_file="level${_level}.pem"

if [[ ! -f "./${_password_file}" ]]; then
    echo "Password file ${_password_file} not exist."
    exit 1
fi

echo "Select level: ${_level}"

# Test login method
if [[ -f "./${_pem_file}" ]]; then
    echo "Key file: ${_pem_file}"
    ssh -i ${_pem_file} -p 2220 ${_user}@bandit.labs.overthewire.org $@
else
    echo "Password file: ${_password_file}"
    read _passwd < ./${_password_file}
    sshpass -p ${_passwd} ssh -p 2220 ${_user}@bandit.labs.overthewire.org $@
fi

#ssh -p 2220 bandit11@bandit.labs.overthewire.org